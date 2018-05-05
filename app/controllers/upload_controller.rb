class UploadController < ApplicationController
    skip_before_action :verify_authenticity_token

    def upload_picture
        picture = params[:picture]
        newName = params[:type] + '_picture-' + Time.now.strftime('%Y%m%d%H%M%S') + '.' + picture.original_filename.split('.').drop(1).join('.')

        File.open(Rails.root.join('public', 'uploads', newName), 'wb') do |file|
            file.write(picture.read)
        end

        createPictureMessageFromTypeAndBroadcast(params[:type], cookies.encrypted[:user], '/uploads/' + newName, params[:id_group], params[:message_to])
    end

    def upload_audio
        audio = params[:audio]

        newName = params[:type] + '_audio-' + Time.now.strftime('%Y%m%d%H%M%S') + '.' + params[:audio_name].split('.').drop(1).join('.')

        File.open(Rails.root.join('public', 'uploads', newName), 'wb') do |file|
            file.write(audio.read)
        end

        createAudioMessageFromTypeAndBroadcast(params[:type], cookies.encrypted[:user], '/uploads/' + newName, params[:id_group], params[:message_to])
    end
    
    private 
    
    def createPictureMessageFromTypeAndBroadcast(type, from, content, groupId, to)
        if type == 'lobby'
            LobbyMessage.create(:from => from, :content => content, :messageType => 'picture')
            ActionCable.server.broadcast "lobby:messages", { from: from, picture: { name: content.split('/').last, href: content }  }
        elsif type == 'group'
            GroupMessage.create(:id_group => groupId, :from => from, :content => content, :messageType => 'picture')
            ActionCable.server.broadcast "group" + groupId + ":messages", { from: from, picture: { name: content.split('/').last, href: content }  }
        elsif type == 'private'
            PrivateMessage.create({:from => from, :to => to, :content => content, :messageType => 'picture'})
            ActionCable.server.broadcast "private::#{from}::#{to}::messages", { from: from, to: to, picture: { name: content.split('/').last, href: content } }
            ActionCable.server.broadcast "private::#{to}::#{from}::messages", { from: from, to: to, picture: { name: content.split('/').last, href: content } }
        end
    end
    
    def createAudioMessageFromTypeAndBroadcast(type, from, content, groupId, to)
        if type == 'lobby'
            LobbyMessage.create(:from => from, :content => content, :messageType => 'audio')
            ActionCable.server.broadcast "lobby:messages", { from: from, audio: { name: content.split('/').last, href: content }  }
        elsif type == 'group'
            GroupMessage.create(:id_group => groupId, :from => from, :content => content, :messageType => 'audio')
            ActionCable.server.broadcast "group" + groupId + ":messages", { from: from, audio: { name: content.split('/').last, href: content }  }
        elsif type == 'private'
            PrivateMessage.create({:from => from, :to => to, :content => content, :messageType => 'audio'})
            ActionCable.server.broadcast "private::#{from}::#{to}::messages", { from: from, to: to, audio: { name: content.split('/').last, href: content } }
            ActionCable.server.broadcast "private::#{to}::#{from}::messages", { from: from, to: to, audio: { name: content.split('/').last, href: content } }
        end
    end
end
