# frozen_string_literal: true

Rails.application.routes.draw do
    resources :turnos
    devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' },
                       path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
    resources :requests
    resources :reviews
    resources :chats
    resources :users
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    devise_scope :user do
        unauthenticated do
            root 'users/sessions#new', as: :unauthenticated_root
        end
        authenticated do
            root 'homepages#index', as: :authenticated_root
        end
    end
    get '/admin_user_reviews', to: 'users#admin_user_reviews'
    get '/ban_user', to: 'users#ban_user'
    get '/unban_user', to: 'users#unban_user'
    get '/mis_resenas', to: 'reviews#mis_resenas'
    get '/turnos_inscribed', to: 'turnos#turnos_inscribed'
    get '/homepages', to: 'homepages#index'
    get '/usuario_requests', to: 'requests#usuario_requests'
    get '/add_member', to: 'turnos#add_member'
    get '/my_requests', to: 'requests#my_requests'
    get '/chat_room', to: 'chats#chat_room'
    get '/remove_member', to: 'turnos#remove_member'
end
