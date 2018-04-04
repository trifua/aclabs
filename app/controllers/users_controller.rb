class UsersController < ApplicationController

	#render form -> html
	def new
		@user = User.new
	end

	#save button
	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			redirect_to '/'
		else
			redirect_to '/signup', alert: 'Invalid name/password combination'
		end
	end

	def user_params
		params.require(:user).permit(:name, :password, :password_confirmation)
	end

end