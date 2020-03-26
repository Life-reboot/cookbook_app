class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    render "index.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    @recipe = Recipe.new(
      title: params[:title],
      chef: params[:chef],
      prep_time: params[:prep_time],
      ingredients: params[:ingredients],
      directions: params[:directions],
      image_url: params[:image_url],
      user_id: 1,
    )
    @recipe.save
    # render "show.html.erb"
    redirect_to "/recipes/#{@recipe.id}"
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render "show.html.erb"
  end

  def edit
    @recipe = Recipe.find_by(id: params[:id])
    render "edit.html.erb"
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.title = params[:title]
    @recipe.ingredients = params[:ingredients]
    @recipe.directions = params[:directions]
    @recipe.chef = params[:chef]
    @recipe.prep_time = params[:prep_time]
    @recipe.image_url = params[:image_url]
    @recipe.save
    redirect_to "/recipes/#{@recipe.id}"
  end
end
