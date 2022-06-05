class CallbacksController < Devise::OmniauthCallbacksController
  def spotify
    # @user = User.from_omniauth(request.env["omniauth.auth"])
    # user_session_path

    @user = User.from_omniauth(request.env["omniauth.auth"])
    # @user = RSpotify::User.new(request.env['omniauth.auth'])
    puts @user.errors.to_a

    if @user
      sign_in_and_redirect @user, :event => :authentication

    else
      session["devise.#{provider_name}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
