Doorkeeper::Application.destroy_all

application = Doorkeeper::Application.create!({
  :name => "Rapidash",
  :redirect_uri => "http://localhost:3000"
})

application.update_column(:secret, "secret")
application.update_column(:uid, "uid")

token = application.access_tokens.create!

token.update_column(:token, "token")
