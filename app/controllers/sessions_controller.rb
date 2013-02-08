class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']

    @identity = Identity.find_with_omniauth(auth)

    if current_user
      if current_user.linked_identity?(auth)
        redirect_to root_url, notice: "Already linked that account!"
      else
        current_user.link_identity!(auth)
        redirect_to root_url, notice: "Successfully linked that account!"
      end
    else
      if identity = Identity.find_with_omniauth(auth)
        user = identity.user
        session[:user_id] = user.id
        redirect_to root_url, notice: "Signed in!"
      else
        user = User.create_with_omniauth(auth)
        session[:user_id] = user.id
        redirect_to root_url, notice: "finished registering"
      end
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "logout"
  end
end
