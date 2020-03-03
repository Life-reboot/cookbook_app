Rails.application.routes.draw do
  namespace :api do
    get "/one_recipe_url" => "recipes#one_recipe_method"
  end
end
