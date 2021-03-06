class Api::RecipesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    @recipes = Recipe.all

    if params[:search]
      @recipes = @recipes.where("title ILIKE ?", "%#{params[:search]}%")
    end

    @recipes = @recipes.order(:id => :asc)

    render "index.json.jb"
  end

  def create
    if params[:input_image_file]
      response = Cloudinary::Uploader.upload(params[:input_image_file])
      image_url = response["secure_url"]
    else
      image_url = params[:input_image_url]
    end

    @recipe = Recipe.new(
      title: params[:input_title],
      chef: params[:input_chef],
      ingredients: params[:input_ingredients],
      directions: params[:input_directions],
      prep_time: params[:input_prep_time],
      image_url: image_url,
      user_id: current_user.id,
    )
    if @recipe.save
      render "show.json.jb"
    else
      render json: { errors: @recipe.errors.full_messages }, status: 422
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render "show.json.jb"
  end

  def update
    @recipe = current_user.recipes.find_by(id: params[:id])
    @recipe.title = params[:input_title] || @recipe.title
    @recipe.ingredients = params[:input_ingredients] || @recipe.ingredients
    @recipe.directions = params[:input_directions] || @recipe.directions
    @recipe.chef = params[:input_chef] || @recipe.chef
    @recipe.prep_time = params[:input_prep_time] || @recipe.prep_time
    @recipe.image_url = params[:input_image_url] || @recipe.image_url
    if @recipe.save
      render "show.json.jb"
    else
      render json: { errors: @recipe.errors.full_messages }, status: 422
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.destroy
    render json: { message: "Recipe destroyed successfully!" }
  end
end
