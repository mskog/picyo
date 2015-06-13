module AuthHelper
  def token_auth(user = FactoryGirl.create(:user))
    @env ||= {}
    @env['X-USER-EMAIL'] = user.email
    @env['X-USER-TOKEN'] = user.authentication_token
  end
end
