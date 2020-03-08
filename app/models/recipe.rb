class Recipe < ApplicationRecord
  def directions_list
    directions.split(", ")
  end

  def ingredients_list
    new_ingredients = []
    ingredients.split(", ").each do |ingredient|
      new_ingredients << ingredient.downcase
    end
    new_ingredients
  end

  def friendly_created_at
    created_at.strftime("%B %e, %Y")
  end

  def friendly_prep_time
    hours = prep_time / 60
    minutes = prep_time % 60
    result = ""
    result += "#{hours} hours " if hours > 0
    result += "#{minutes} minutes" if minutes > 0
    result
  end
end
