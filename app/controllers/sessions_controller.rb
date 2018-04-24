class SessionsController < ApplicationController
	# GET
	def new
		if session[:user_id] then redirect_to '/welcome' end
	end

	# POST
	def create
		user = User.find_by(name: params[:name])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to '/welcome'
		else
			redirect_to '/login', alert: 'Invalid user'
		end
	end

	# /logout
	def destroy
		session[:user_id] = nil
		redirect_to '/login'
	end
end
