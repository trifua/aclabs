class UsersController < ApplicationController
	# GET
	def new
		@user = User.new
	end

	# POST
	def create
		user = User.new user_params
		if user.save
			session[:user_id] = user.id
			redirect_to '/welcome'
		else
			redirect_to '/signup', alert: 'Invalid name/password combination'
		end

	end

	def user_params
		params.require(:user).permit(:name, :password, :password_confirmation)
	end
end