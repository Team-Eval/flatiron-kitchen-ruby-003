class Recipe < ActiveRecord::Base
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_ingredients

  def add_ingredients(ingredients)
    ingredients.each do |i|
      
    end
  end
end
