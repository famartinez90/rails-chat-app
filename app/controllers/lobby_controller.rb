class LobbyController < ApplicationController
    def join
        redirect_to '/messages/lobby'
    end
end
