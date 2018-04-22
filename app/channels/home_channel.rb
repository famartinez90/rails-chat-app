class HomeChannel < ApplicationCable::Channel
	def subscribed
      	stream_from "home:users"
	end

	def unsubscribed
		User.where(:name => current_user).destroy_all
		
		ActionCable.server.broadcast "home:users", { disconnected_user: current_user }
	end

	def speak(data)
		#FIXME: Esto no deberia estar, se deberia destruir en el unsubscribed
		if !User.exists?(:name => data['connected_user'])
			User.create(:name => data['connected_user'])
			
			ActionCable.server.broadcast "home:users", { connected_user: data['connected_user'] }
		end
	end
end
