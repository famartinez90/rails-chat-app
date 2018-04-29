class GroupsController < ApplicationController
    def create
        @name = params['gname']
        Group.create(:name => @name).save()

        redirect_to '/home'
    end

    def join
        GroupMessage.create(:id_group => params['id_group'], :content => cookies.encrypted[:user] + ' se ha unido al grupo!')

        redirect_to '/messages/group/' + params['id_group']
    end

    def delete
        Group.destroy(params['id_group'])

        redirect_to '/home'
    end
end
