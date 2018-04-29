class MessagesController < ApplicationController
	def getGroupMessages
		channel = ChannelFactory.create(:group, { id_group: params['id_group'] })

		@channelType = channel.getType()
		@user = cookies.encrypted[:user]
		@group = channel.getChannelData()
		@messages = channel.getChannelMessages()

		render template: "chat/chat"
	end
	
	def getLobbyMessages
		channel = ChannelFactory.create(:lobby, {})
		
		@channelType = channel.getType()
		@user = cookies.encrypted[:user]
		@messages = channel.getChannelMessages()

		render template: "chat/chat"
	end

	def getPrivateMessages
		channel = ChannelFactory.create(:private, {})

		@channelType = channel.getType()
		@user = cookies.encrypted[:user]
		@messages = channel.getChannelMessages()

		render template: "chat/chat"
	end
end