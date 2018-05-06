class ChatChannel < ApplicationCable::Channel
	def subscribed
		stream_from "home:users"
	end

	def unsubscribed
	end

	def speak(data)
		if data['connected_user']
			ActionCable.server.broadcast "home:users", data
		end
	end
end
