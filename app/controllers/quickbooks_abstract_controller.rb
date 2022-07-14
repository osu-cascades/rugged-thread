class QuickbooksAbstractController < ApplicationController

  def qbo_authenticated
    qbo_data = QuickbooksSession.first
    if !qbo_data.nil?
      return true
    else
      return false
    end
  end

  def qb_api
    qbo_data = QuickbooksSession.first
    QboApi.new(access_token: qbo_data["access_token"], realm_id: qbo_data["realm_id"])
  end

  def qb_redirect(path, options = {})
    if options[:auth_redirect_path]
      cookies[:auth_redirect_path] = options[:auth_redirect_path]
    else
      cookies.delete :auth_redirect_path
    end
    redirect_to path
  end

  def qb_request(func, options = {})
    if !qbo_authenticated
      qb_redirect qb_oauth_path, options
    else
      begin
        func.call
      rescue
        # Refresh token and try again
        refresh_token
        begin
          func.call
        rescue
          qb_redirect qb_oauth_path, options
        end
      end
    end
  end

  def oauth_client(redirect = "#{request.protocol}#{request.host_with_port}/qb_oauth_verify")
    id = ENV["QB_CLIENT_ID"]
    secret = ENV["QB_CLIENT_SECRET"]
    Rack::OAuth2::Client.new(
      identifier: id,
      secret: secret,
      redirect_uri: redirect,
      authorization_endpoint: "https://appcenter.intuit.com/connect/oauth2",
      token_endpoint: "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer"
    )
  end

  def oauth_authorization_url(client)
    client.authorization_uri(
      scope: "com.intuit.quickbooks.accounting",
      response_type: "code",
      state: "Stitch"
    )
  end

  def refresh_token
    account = QuickbooksSession.first
    client = oauth_client
    client.refresh_token = account.refresh_token
    if res = client.access_token!
      access_token = res.access_token
      # Update database
      account.access_token = access_token
      account.save
    else
      "something went wrong, try again!"
    end
  end

end
