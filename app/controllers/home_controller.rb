class HomeController < ApplicationController
	def index
		if cookies.encrypted[:user]
			redirect_to '/home'
		end
	end

	def logout
		cookies.delete 'user'

		redirect_to '/'
	end

	def home
		unless cookies.encrypted[:user]
			cookies.encrypted[:user] = params['user']
		end

		@groups = Group.all()
	end
end
