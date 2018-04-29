class PrivateController < ApplicationController
    def join
        redirect_to '/messages/private/' + params['to']
    end
end
