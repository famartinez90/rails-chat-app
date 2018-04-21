class GroupChannel < ApplicationCable::Channel
	def subscribed
		stream_from "group#{params['group']}:messages"
	end

	def unsubscribed
	end

	def speak(data)
		Message.create(:id_group => params['group'], :from => data['from'], :content => data['message'])
		ActionCable.server.broadcast "group#{params['group']}:messages", { from: data['from'], message: data['message'] }
	end
end