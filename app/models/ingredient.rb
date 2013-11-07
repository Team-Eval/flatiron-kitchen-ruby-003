class Ingredient < ActiveRecord::Base
  has_many :recipes, through: :recipe_ingredients
  has_many :recipe_ingredients

  def increment_count
    self.count ||= 0
    self.count += 1
  end
end
