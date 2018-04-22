class ChannelFactory
    TYPES = {
        group: GroupChannelController,
        lobby: LobbyChannelController,
        private: PrivateChannelController
    }
    
    def self.create(channel_type, attributes)
        (TYPES[channel_type]).new(attributes)
    end
end