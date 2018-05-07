class GroupChannelController
    TYPE = 'GroupChannel'

    def initialize(attributes)
        @id_group = attributes[:id_group]
    end

    def getType
        return TYPE
    end

    def getChannelData
        return Group.where(:id => @id_group).first()
    end

    def getChannelMessages
        return GroupMessage.where(:id_group => @id_group).order(:created_at)
    end

    def createFileMessageAndBroadcast(from, fileType, content)
        GroupMessage.create(:id_group => @id_group, :from => from, :content => content, :messageType => fileType)
        ActionCable.server.broadcast "group" + @id_group + ":messages", { from: from, file: { name: content.split('/').last, href: content, type: fileType }  }
    end
end