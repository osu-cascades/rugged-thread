class QuickbooksOAuthController < QuickbooksAbstractController

  def index
    client = oauth_client(qb_redirect_path)
    @oauth_authorization_url = oauth_authorization_url(client)
  end

  def verify
    code = params["code"]
    realm = params["realmId"]
    client = oauth_client(qb_redirect_path)
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

      # Check if a redirect exists
      if cookies[:auth_redirect_path]
        path = cookies[:auth_redirect_path]
        cookies.delete :auth_redirect_path
        redirect_to path
      end

    else
      "something went wrong, try again!"
    end
  end

end
