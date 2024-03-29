class AuthenticationsController < ApplicationController
  # protected

  # This is necessary since Rails 3.0.4
  # See https://github.com/intridea/omniauth/issues/185
  # and http://www.arailsdemo.com/posts/44
  def handle_unverified_request
    true
  end

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      user.apply_omniauth(omniauth)
      user.email = omniauth['extra']['raw_info']['email']
      user.first_name = omniauth['extra']['raw_info']['first_name']
      user.last_name = omniauth['extra']['raw_info']['last_name']

      if user.save!
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
        # redirect_to root_path
      else
        session[:omniauth] = omniauth
        redirect_to new_user_registration_url
        # redirect_to root_path
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
