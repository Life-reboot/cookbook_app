class Api::RecipesController < ApplicationController
  def one_recipe_method
    @recipe = Recipe.first
    render "one_recipe.json.jb"
  end
end
