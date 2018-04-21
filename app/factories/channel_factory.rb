class ChannelFactory
    TYPES = {
        group: GroupChannelController,
        public: PublicChannelController,
        private: PrivateChannelController
    }
    
    def self.create(channel_type, attributes)
        (TYPES[channel_type]).new(attributes)
    end
end