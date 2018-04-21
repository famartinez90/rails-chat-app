class MessagesController < ApplicationController
	def getGroupMessages
		channel = ChannelFactory.create(:group, { id_group: params['id_group'] })

		@channelType = channel.getType()
		@user = session[:user]
		@group = channel.getChannelData()
		@messages = channel.getChannelMessages()
	end

	def getPulicMessages
		# TODO
	end

	def getPrivateMessages
		# TODO
	end
end