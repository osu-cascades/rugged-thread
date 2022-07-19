require "quickbooks"

class QuickbooksAbstractController < ApplicationController

  def qbo_authenticated?
    !QuickbooksSession.first.nil?
  end

  def qb_api
    Quickbooks.qbo_api
  end

  def qb_redirect_path
    "#{request.protocol}#{request.host_with_port}/qb_oauth"
  end

  def qb_redirect_verify_path
    "#{request.protocol}#{request.host_with_port}/qb_oauth_verify"
  end

  def qb_redirect(path, options = {})
    if options[:auth_redirect_path]
      cookies[:auth_redirect_path] = options[:auth_redirect_path]
    else
      cookies.delete :auth_redirect_path
    end
    redirect_to path
  end

  def qb_request(options = {
      auth_redirect_path: request.original_fullpath,
      clear_cache: true
    })
    begin
      Quickbooks.request(options) do
        yield
      end
    rescue Quickbooks::DataUninitializedError
      qb_redirect qb_redirect_path, options
    rescue Quickbooks::UnauthorizedError
      tries = 0
      while tries < 3
        refresh_token!
        begin
          return Quickbooks.request(options) do
            yield
          end
        rescue Quickbooks::UnauthorizedError
          tries += 1
        end
      end
      qb_redirect qb_redirect_path, options
    end
  end

  def oauth_client(redirect = nil)
    Quickbooks.oauth_client(redirect)
  end

  def oauth_authorization_url(client)
    Quickbooks.oauth_authorization_url(client)
  end

  def refresh_token!
    account = QuickbooksSession.first
    client = oauth_client(qb_redirect_verify_path)
    client.refresh_token = account.refresh_token
    begin
      if res = client.access_token!
        access_token = res.access_token
        # Update database
        account.access_token = access_token
        account.save
      else
        "something went wrong, try again!"
      end
    rescue
      # Invalid refresh token, caller should redirect to oauth page
    end
  end

end
