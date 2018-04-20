Rails.application.routes.draw do
  get '/', to: 'home#index' #ingresar usuarios
  get '/messages', to: 'messages#show' #chat
  mount ActionCable.server => '/cable'
end
