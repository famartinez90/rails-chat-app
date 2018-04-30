class PrivateChannel < ApplicationCable::Channel
	def subscribed
		stream_from "private::#{current_user}::#{params['to']}::messages"
	end

	def unsubscribed
	end

	def speak(data)
    	PrivateMessage.create({:from => data['from'], :to => data['to'], :content => data['message'], :messageType => 'text'})
		ActionCable.server.broadcast "private::#{current_user}::#{params['to']}::messages", {from: data['from'], to: data['to'], message: data['message']}
		ActionCable.server.broadcast "private::#{params['to']}::#{current_user}::messages", {from: data['from'], to: data['to'], message: data['message']}
	end
end