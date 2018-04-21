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
        return Message.where(:id_group => @id_group).order(:created_at)
    end
end