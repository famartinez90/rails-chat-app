class LobbyChannel < ApplicationCable::Channel
	def subscribed
		stream_from "lobby:messages"
	end

	def unsubscribed
	end

	def speak(data)
		LobbyMessage.create(:from => data['from'], :content => data['message'], :messageType => 'text')
		ActionCable.server.broadcast "lobby:messages", { from: data['from'], message: data['message'] }
	end
end