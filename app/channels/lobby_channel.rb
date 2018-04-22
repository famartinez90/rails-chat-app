class LobbyChannel < ApplicationCable::Channel
	def subscribed
        stream_from "lobby:messages"
        
        LobbyMessage.create(:content => "#{params[:user]} ha ingresado al lobby!")
        ActionCable.server.broadcast "lobby:messages", { message: "#{params[:user]} ha ingresado al lobby!" }
	end

	def unsubscribed
	end

	def speak(data)
		LobbyMessage.create(:from => data['from'], :content => data['message'])
		ActionCable.server.broadcast "lobby:messages", { from: data['from'], message: data['message'] }
	end
end