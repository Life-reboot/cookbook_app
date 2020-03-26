Rails.application.routes.draw do
  get "/recipes" => "recipes#index"
  get "/recipes/new" => "recipes#new"
  post "/recipes" => "recipes#create"
  get "/recipes/:id" => "recipes#show"
  get "/recipes/:id/edit" => "recipes#edit"
  patch "/recipes/:id" => "recipes#update"

  namespace :api do
    post "/users" => "users#create"

    post "/sessions" => "sessions#create"

    get "/recipes" => "recipes#index"
    post "/recipes" => "recipes#create"
    get "/recipes/:id" => "recipes#show"
    patch "/recipes/:id" => "recipes#update"
    delete "/recipes/:id" => "recipes#destroy"
  end
end
