class MessagesController < ApplicationController
	def getGroupMessages
		channel = ChannelFactory.create(:group, { id_group: params['id_group'] })

		@channelType = channel.getType()
		@type = 'group'
		@user = cookies.encrypted[:user]
		@group = channel.getChannelData()
		@messages = channel.getChannelMessages()

		render template: "chat/chat"
	end
	
	def getLobbyMessages
		channel = ChannelFactory.create(:lobby, {})
		
		@channelType = channel.getType()
		@type = 'lobby'
		@user = cookies.encrypted[:user]
		@messages = channel.getChannelMessages()

		render template: "chat/chat"
	end

	def getPrivateMessages
		current_user = cookies.encrypted[:user]
		to = params['id_user']
		channel = ChannelFactory.create(:private, {from: current_user, to: to})

		@channelType = channel.getType()
		@type = 'private'
		@user = current_user
		@message_to = to
		@messages = channel.getChannelMessages()

		render template: "chat/chat"
	end
end