class GroupsController < ApplicationController
    def create
        @name = params['gname']
        Group.create(:name => @name).save()

        redirect_to '/home'
    end

    def join
        Message.create(:id_group => params['id_group'], :content => session[:user] + ' se ha unido al grupo!')

        redirect_to '/messages/group/' + params['id_group']
    end

    def delete
        Group.destroy(params['id_group'])

        redirect_to '/home'
    end
end
