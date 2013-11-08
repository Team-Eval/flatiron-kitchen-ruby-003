require 'spec_helper'

describe "creating ingredients" do
  context "on the new ingredient page" do
    before do
      visit new_ingredient_path
    end

    # Is there a form with the given HTML ID?
    it "should have a form to create the ingredients" do
      expect(page).to have_css("form#new_ingredient")
    end

    # After submitting the form out with the given name, does the
    # ingredient exist in the database?
    #
    # Is the user redirected to a page that displays the ingredient name?
    it "should create an ingredient when the form is submitted" do
      fill_in 'ingredient_name', with: 'Parsley'
      click_button('Create Ingredient')

      Ingredient.first.name.should == "Parsley"
      expect(page).to have_content("Parsley")
    end
  end
end


describe "ingredients" do
  before do
    @salmon = Ingredient.create(:name => "Salmon Gams", :count => 0)
    @pie = @salmon.recipes.build(name: "Joshie Poshie Pie", ingredient_ids: [@salmon.id])
    @salmon.save
  end

  it "should have a count" do
    visit edit_ingredient_path(Ingredient.first)
    fill_in 'ingredient_count', with: '7'
    click_button('Update Ingredient')
    expect(page).to have_content("7")
  end
  
  it "adding more of the ingredient should increase the count" do
    visit ingredients_path
    click_link('$')
    expect(page).to have_content("1")
  end

  context "there are enough ingredients for the recipe" do
    it "displays an updated count when the recipe is cooked" do
      Ingredient.find(@salmon).update(:count => 7)
      visit recipe_path(@pie)
      click_link("Make recipe!")
      expect(Ingredient.find(@salmon).count).to eq(6)
      expect(page).to have_content("Recipe was successfully cooked!")
    end
  end
end