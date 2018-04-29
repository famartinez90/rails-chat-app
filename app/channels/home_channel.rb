class HomeChannel < ApplicationCable::Channel
	def subscribed
		stream_from "home:users"
	end

	def unsubscribed
		ActionCable.server.broadcast "home:users", { disconnected_user: current_user }
	end

	def speak(data)
		ActionCable.server.broadcast "home:users", data
	end
end
