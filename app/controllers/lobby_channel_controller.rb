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
end