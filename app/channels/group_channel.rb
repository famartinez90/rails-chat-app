class GroupChannel < ChatChannel
	def subscribed
		super
		stream_from "group#{params['group']}:messages"
	end

	def unsubscribed
		super
	end

	def speak(data)
		super(data)
		GroupMessage.create(:id_group => params['group'], :from => data['from'], :content => data['message'], :messageType => 'text')
		ActionCable.server.broadcast "group#{params['group']}:messages", { from: data['from'], message: data['message'] }
	end
end
