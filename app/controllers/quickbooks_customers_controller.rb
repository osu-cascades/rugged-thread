class QuickbooksCustomersController < ApplicationController

  def qbo_authenticated
    qbo_data = QuickbooksSession.first
    if qbo_data
      return true
    else
      return false
    end
  end

  def oauth
    redirect_url = "#{request.protocol}#{request.host_with_port}/quickbooks_customers/oauth_verify"
    client = _oauth_client(redirect_url)
    @oauth_authorization_url = _oauth_authorization_url(client)
  end

  def _oauth_client(redirect = "#{request.protocol}#{request.host_with_port}/quickbooks_customers/oauth_verify")
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
    client = _oauth_client
    client.authorization_code = code
    if res = client.access_token!
      refresh_token = res.refresh_token
      access_token = res.access_token
      # Update / create database
      account = QuickbooksSession.first
      if !account
        account = QuickbooksSession.new
      end
      account.realm_id = realm
      account.refresh_token = refresh_token
      account.access_token = access_token
      account.save
    else
      "something went wrong, try again!"
    end
  end

  def show
    if !qbo_authenticated
      return redirect_to quickbooks_customers_oauth_path
    else
      qbo_data = QuickbooksSession.first
      qbo_api = QboApi.new(access_token: qbo_data["access_token"], realm_id: qbo_data["realm_id"])
      begin
        @customer = qbo_api.get(:customer, params["id"])
        logger.info @customer.to_s
      rescue
        return redirect_to quickbooks_customers_oauth_path
      end
    end
  end

end
