class PrivateChannelController
    TYPE = 'PrivateChannel'

    def initialize(attributes)
        @from = attributes[:from]
        @to = attributes[:to]
    end

    def getType
        return TYPE
    end

    def getChannelData
    end

    def getChannelMessages
        return PrivateMessage
                   .where(:from => @from, :to => @to)
                   .or(PrivateMessage.where(:from => @to, :to => @from))
                   .order(:created_at)
    end
end