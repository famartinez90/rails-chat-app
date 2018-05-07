class UploadController < ApplicationController
    skip_before_action :verify_authenticity_token

    def upload_picture
        picture = params[:picture]
        newName = params[:type] + '_picture-' + Time.now.strftime('%Y%m%d%H%M%S') + '.' + picture.original_filename.split('.').drop(1).join('.')

        File.open(Rails.root.join('public', 'uploads', newName), 'wb') do |file|
            file.write(picture.read)
        end

        createFileMessage(params[:type], '/uploads/' + newName, 'picture')
    end

    def upload_audio
        audio = params[:audio]

        newName = params[:type] + '_audio-' + Time.now.strftime('%Y%m%d%H%M%S') + '.' + params[:audio_name].split('.').drop(1).join('.')

        File.open(Rails.root.join('public', 'uploads', newName), 'wb') do |file|
            file.write(audio.read)
        end

        createFileMessage(params[:type], '/uploads/' + newName, 'audio')
    end
    
    private
    
    def createFileMessage(type, content, fileType)
        if type == 'lobby'
            channel = ChannelFactory.create(:lobby, {})
            channel.createFileMessageAndBroadcast(cookies.encrypted[:user], fileType, content)
        elsif type == 'group'
            channel = ChannelFactory.create(:group, { id_group: params[:id_group] })
            channel.createFileMessageAndBroadcast(cookies.encrypted[:user], fileType, content)
        elsif type == 'private'
            channel = ChannelFactory.create(:private, { from: cookies.encrypted[:user], to: params[:message_to] })
            channel.createFileMessageAndBroadcast(cookies.encrypted[:user], fileType, content)
        end
    end
end
