class QuickbooksAbstractController < ApplicationController

  def qbo_authenticated
    qbo_data = QuickbooksSession.first
    if !qbo_data.nil?
      return true
    else
      return false
    end
  end

  def qb_request(func)
    if !qbo_authenticated
      redirect_to qb_oauth_path
    else
      begin
        func.call
      rescue
        # Refresh token and try again
        refresh_token
        begin
          func.call
        rescue
          redirect_to qb_oauth_path
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
    client = oauth_client
    if res = client.access_token!
      refresh_token = res.refresh_token
      access_token = res.access_token
      # Update database
      account = QuickbooksSession.first
      account.refresh_token = refresh_token
      account.access_token = access_token
      account.save
    else
      "something went wrong, try again!"
    end
  end

end
