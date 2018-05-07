class LobbyChannelController
    TYPE = 'LobbyChannel'

    def initialize(attributes)
    end

    def getType
        return TYPE
    end

    def getChannelData
    end

    def getChannelMessages
        return LobbyMessage.order(:created_at)
    end

    def createFileMessageAndBroadcast(from, fileType, content)
        LobbyMessage.create(:from => from, :content => content, :messageType => fileType)
        ActionCable.server.broadcast "lobby:messages", { from: from, file: { name: content.split('/').last, href: content, type: fileType }  }
    end
end