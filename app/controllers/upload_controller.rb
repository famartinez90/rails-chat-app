class UploadController < ApplicationController
    def upload
        uploadFile = params[:file]
        newName = params[:type] + '_file-' + Time.now.strftime('%Y%m%d%H%M%S') + '.' + uploadFile.original_filename.split('.').drop(1).join('.')

        File.open(Rails.root.join('public', 'uploads', newName), 'wb') do |file|
            file.write(uploadFile.read)
        end

        createFileMessageFromTypeAndBroadcast(params[:type], cookies.encrypted[:user], '/uploads/' + newName, params[:id_group], params[:message_to])
    end
    
    private 
    
    def createFileMessageFromTypeAndBroadcast(type, from, content, groupId, to)
        if type == 'lobby'
            LobbyMessage.create(:from => from, :content => content, :messageType => 'file')
            ActionCable.server.broadcast "lobby:messages", { from: from, file: { name: content.split('/').last, href: content }  }
        elsif type == 'group'
            GroupMessage.create(:id_group => groupId, :from => from, :content => content, :messageType => 'file')
            ActionCable.server.broadcast "group" + groupId + ":messages", { from: from, file: { name: content.split('/').last, href: content }  }
        elsif type == 'private'
            PrivateMessage.create({:from => from, :to => to, :content => content, :messageType => 'file'})
            ActionCable.server.broadcast "private::#{from}::#{to}::messages", { from: from, to: to, file: { name: content.split('/').last, href: content } }
		    ActionCable.server.broadcast "private::#{to}::#{from}::messages", { from: from, to: to, file: { name: content.split('/').last, href: content } }
        end
    end
end
