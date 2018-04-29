Rails.application.routes.draw do
	get '/', to: 'home#index' #ver grupos y crear
	post '/logout', to: 'home#logout' #logout
	post '/home', to: 'home#home' #ingresar usuario
	get '/home', to: 'home#home' #ingresar usuario
	post '/group', to: 'groups#create' #crear grupo
	delete '/group/delete/:id_group', to: 'groups#delete' #eliminar grupo
	post '/group/join/:id_group', to: 'groups#join' #unirse a grupo
	post '/lobby/join', to: 'lobby#join' #unirse a grupo
	get '/messages', to: 'messages#show' #chat
	get '/messages/group/:id_group', to: 'messages#getGroupMessages' #ver mensajes de grupo
	get '/messages/lobby', to: 'messages#getLobbyMessages' #ver mensajes publicos
  get '/messages/private/:id_user', to: 'messages#getPrivateMessages' #ver mensajes privados con usuarios
  post '/upload', to: 'upload#uploadImage'
	mount ActionCable.server => '/cable'
end
