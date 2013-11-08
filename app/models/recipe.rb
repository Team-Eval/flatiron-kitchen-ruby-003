class Recipe < ActiveRecord::Base
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_ingredients

  def cook!
    if enough_ingredients?
      self.ingredients.each do |i|
        i.update(:count => i.count-1)
      end
    end
  end

  def enough_ingredients?
    self.ingredients.minimum(:count) > 0
  end
end
