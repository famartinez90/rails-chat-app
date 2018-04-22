class UploadController < ApplicationController
    def uploadImage
        @file = params[:file]
        file_name = @file.original_filename
        FileUtils.mv @file.tempfile, "/storage/#{file_name}"
    end
end
