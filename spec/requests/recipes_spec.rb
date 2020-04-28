require "rails_helper"

RSpec.describe "Recipes", type: :request do
  describe "GET /recipes" do
    it "returns an array of recipes" do
      user = User.create!(name: "Peter", email: "peter@example.com", password: "password")
      Recipe.create!(title: "example title 1", chef: "example chef", ingredients: "example ingredients", directions: "...", image_url: "...", prep_time: 100, user_id: user.id)
      Recipe.create!(title: "example title 2", chef: "example chef", ingredients: "example ingredients", directions: "...", image_url: "...", prep_time: 100, user_id: user.id)
      Recipe.create!(title: "example title 3", chef: "example chef", ingredients: "example ingredients", directions: "...", image_url: "...", prep_time: 100, user_id: user.id)

      get "/api/recipes"
      recipes = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(recipes.length).to eq(3)
    end
  end

  describe "POST /recipes" do
    it "creates a recipe" do
      user = User.create!(name: "Peter", email: "peter@example.com", password: "password")
      jwt = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      params = {
        input_title: "New title",
        input_chef: "New chef",
        input_prep_time: "100",
        input_ingredients: "New ingredients",
        input_directions: "New directions",
        input_image_url: "new image url",
      }
      post "/api/recipes", params: params, headers: { "Authorization" => "Bearer #{jwt}" }
      recipe = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(recipe["title"]).to eq("New title")
    end
  end

  describe "GET /recipes/:id" do
    it "returns a hash with the appropriate attributes" do
      user = User.create!(name: "Peter", email: "peter@example.com", password: "password")
      recipe = Recipe.create!(title: "example title 1", chef: "example chef", ingredients: "example ingredients", directions: "...", image_url: "...", prep_time: 100, user_id: user.id)

      get "/api/recipes/#{recipe.id}"
      recipe = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(recipe["title"]).to eq("example title 1")
      expect(recipe["chef"]).to eq("example chef")
    end
  end
end
