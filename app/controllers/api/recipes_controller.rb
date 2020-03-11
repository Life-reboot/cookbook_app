class Api::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    if params[:search]
      @recipes = @recipes.where("title ILIKE ?", "%#{params[:search]}%")
    end

    @recipes = @recipes.order(:id => :asc)

    render "index.json.jb"
  end

  def create
    @recipe = Recipe.new(
      title: params[:input_title],
      chef: params[:input_chef],
      ingredients: params[:input_ingredients],
      directions: params[:input_directions],
      prep_time: params[:input_prep_time],
      image_url: params[:input_image_url],
    )
    @recipe.save
    render "show.json.jb"
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render "show.json.jb"
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.title = params[:input_title] || @recipe.title
    @recipe.ingredients = params[:input_ingredients] || @recipe.ingredients
    @recipe.directions = params[:input_directions] || @recipe.directions
    @recipe.chef = params[:input_chef] || @recipe.chef
    @recipe.prep_time = params[:input_prep_time] || @recipe.prep_time
    @recipe.image_url = params[:input_image_url] || @recipe.image_url
    @recipe.save
    render "show.json.jb"
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.destroy
    render json: { message: "Recipe destroyed successfully!" }
  end
end
