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

    def createFileMessageAndBroadcast(from, fileType, content)
        PrivateMessage.create({:from => from, :to => @to, :content => content, :messageType => fileType})
        ActionCable.server.broadcast "private::#{from}::#{@to}::messages", { from: from, to: @to, file: { name: content.split('/').last, href: content, type: fileType } }
        ActionCable.server.broadcast "private::#{@to}::#{from}::messages", { from: from, to: @to, file: { name: content.split('/').last, href: content, type: fileType } }
    end
end