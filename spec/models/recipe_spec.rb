require 'spec_helper'

describe Recipe do

  let(:ingredient1) { Ingredient.create(:name => "Sugar", :count => 1)}
  let(:ingredient2) { Ingredient.create(:name => "Spice", :count => 1)}
  let(:ingredient3) { Ingredient.create(:name => "Nice", :count => 1)}
  
  let(:recipe) { Recipe.create(:name => "PowerPuffGirls", :ingredients => [ingredient1, ingredient2, ingredient3]) }

  context '#enough_ingredients?' do
    context 'there are enough ingredients for the recipe' do 
      it 'should return true' do
        expect(recipe.enough_ingredients?).to be true
      end
    end

    context 'there are not enough ingredients for the recipe' do 
      it 'should return false' do
        ingredient1.update(:count => 0)
        expect(recipe.enough_ingredients?).to be false
      end
    end
  end

  context '#cook' do
    it "lowers all ingredients from 1 to 0" do
      ingredient1.update(:count => 1)
      recipe.cook!
      expect(recipe.ingredients.maximum(:count)).to eq(0)
    end

    it "lowers one ingredient's count by 1" do
      ingredient1.update(:count => 5)
      recipe.cook!
      expect(recipe.ingredients.first.count).to eq(4)
    end
  end



end