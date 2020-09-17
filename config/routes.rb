Rails.application.routes.draw do
  devise_for :users
  resources :dishes
  resources :menus
  
  get 'menus/:id/add_dish', to: "menus#add", as: "add_dish"


  delete 'menus/:id/remove_dish/:dish_id', to: "menus#remove", as:"remove_dish"

  post 'menus/:id/post_add', to: "menus#post_add", as:"post_dish"
  root "menus#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
