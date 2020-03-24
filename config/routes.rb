Rails.application.routes.draw do
  get "/recipes" => "recipes#index"

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
