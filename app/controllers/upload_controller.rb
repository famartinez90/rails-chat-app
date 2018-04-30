class UploadController < ApplicationController
    def upload
        uploadFile = params[:file]
        newName = 'lobby_file-' + Time.now.strftime('%Y%m%d%H%M%S') + '.' + uploadFile.original_filename.split('.').drop(1).join('.')

        File.open(Rails.root.join('public', 'uploads', newName), 'wb') do |file|
            file.write(uploadFile.read)
        end

        createFileMessageFromType(params[:type], params[:from], '/uploads/' + newName)

        redirect_to '/messages/lobby'
    end

    private 
    
    def createFileMessageFromType(type, from, content)
        if type == 'lobby'
            LobbyMessage.create(:from => from, :content => content, :messageType => 'file')
        end
    end     
end
