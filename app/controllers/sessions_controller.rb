class SessionsController < ApplicationController
  skip_before_action :authorize, only: %i[new create]

  def new
    redirect_to '/', alert: 'Already logged in' if logged_in?
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login', alert: 'Invalid user'
    end
  end

  def destroy
    if current_user
      session[:user_id] = nil
      redirect_to '/login'
    else
      redirect_to '/welcome'
    end
  end
end
