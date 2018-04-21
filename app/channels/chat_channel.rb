class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
  end

  def speak(data)
    Message.create(:id_group => data["id_group"], :from => data['user'], :content => data["message"])
    ActionCable.server.broadcast "chat_channel", data
  end
end
