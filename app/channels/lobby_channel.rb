class LobbyChannel < ChatChannel
	def subscribed
		super
		stream_from "lobby:messages"
	end

	def unsubscribed
		super
	end

	def speak(data)
		super(data)
		LobbyMessage.create(:from => data['from'], :content => data['message'], :messageType => 'text')
		ActionCable.server.broadcast "lobby:messages", { from: data['from'], message: data['message'] }
	end
end
