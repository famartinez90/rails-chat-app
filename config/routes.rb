Rails.application.routes.draw do
	get '/', to: 'home#login'
	post '/logout', to: 'home#logout'
	post '/home', to: 'home#home'
	get '/home', to: 'home#home'
	post '/group', to: 'groups#create'
	delete '/group/delete/:id_group', to: 'groups#delete'
	post '/group/join/:id_group', to: 'groups#join'
	post '/lobby/join', to: 'lobby#join'
  post '/private/join', to: 'private#join'
	get '/messages', to: 'messages#show'
	get '/messages/group/:id_group', to: 'messages#getGroupMessages'
	get '/messages/lobby', to: 'messages#getLobbyMessages'
  get '/messages/private/:id_user', to: 'messages#getPrivateMessages'
  post '/upload/picture', to: 'upload#upload_picture'
  post '/upload/audio', to: 'upload#upload_audio'
	mount ActionCable.server => '/cable'
end
