class AddCountToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :count, :integer
  end
end
