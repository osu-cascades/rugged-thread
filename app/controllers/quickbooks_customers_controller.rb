class QuickbooksCustomersController < ApplicationController

  def qbo_authenticated
    qbo_data = QuickbooksSession.first
    if qbo_data
      now = Time.now.to_i
      access_token_expires = qbo_data["access_token_expires"].to_i
      refresh_token_expires = qbo_data["refresh_token_expires"].to_i
      if now >= refresh_token_expires
        return false
      end
      # TODO: if possible, refresh access token
      if now >= access_token_expires
      end
    else
      return false
    end
  end

  def oauth
    client_id = ENV["QB_CLIENT_ID"]
    client_secret = ENV["QB_CLIENT_SECRET"]
    redirect_url = "#{request.protocol}#{request.host_with_port}/quickbooks_customers/oauth_verify"
    client = _oauth_client(client_id, client_secret, redirect_url)
    @oauth_authorization_url = _oauth_authorization_url(client)
  end

  def _oauth_client(id, secret, redirect)
    Rack::OAuth2::Client.new(
      identifier: id,
      secret: secret,
      redirect_uri: redirect,
      authorization_endpoint: "https://appcenter.intuit.com/connect/oauth2",
      token_endpoint: "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer"
    )
  end

  def _oauth_authorization_url(client)
    client.authorization_uri(
      scope: "com.intuit.quickbooks.accounting",
      response_type: "code",
      state: "Stitch"
    )
  end

  def oauth_verify
    code = params["code"]
    realm = params["realmId"]
  end

  def show
    if !qbo_authenticated
      return redirect_to quickbooks_customers_oauth_path
    end
  end

end
