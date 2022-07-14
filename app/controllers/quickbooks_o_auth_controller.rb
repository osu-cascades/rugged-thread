class QuickbooksOAuthController < QuickbooksAbstractController

  def index
    redirect_url = "#{request.protocol}#{request.host_with_port}/qb_oauth_verify"
    client = oauth_client(redirect_url)
    @oauth_authorization_url = oauth_authorization_url(client)
  end

  def verify
    code = params["code"]
    realm = params["realmId"]
    client = oauth_client
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

end
