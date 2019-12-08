Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id/edit', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/shelters/:id/pets', to: 'shelters#showpets'
  get '/shelters/:id/pets/new', to: 'pets#new'
  get '/shelters/:id/reviews/new', to: 'reviews#new'
  post '/shelters/:id/reviews/new', to: 'reviews#create'
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'
  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  post 'shelters/:shelter_id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'
  patch '/pets/:id/pending', to: 'pets#topending'
  patch '/pets/:id/adoptable', to: 'pets#toadoptable'
  get '/favorites/:pet_id', to: 'favorites#add_favorite'
  delete '/favorites/all', to: 'favorites#destroy_all'
  delete '/favorites/:pet_id', to: 'favorites#destroy'
  get '/favorites', to: 'favorites#index'
  delete '/favorites/:pet_id/index', to: 'favorites#destroy_from_index'
end
