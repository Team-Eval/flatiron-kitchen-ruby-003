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
    salmon = Ingredient.create(name: "Salmon Gams")
    @pie = Recipe.create(name: "Joshie Poshie Pie", ingredient_ids: [salmon.id])
    visit edit_ingredient_path(Ingredient.first)
    fill_in 'ingredient_count', with: '7'
    click_button('Update Ingredient')
  end

  it "should have a count" do
    expect(page).to have_content("7")
  end
  
  it "adding more of the ingredient should increase the count" do
    visit ingredients_path
    click_link('$')
    expect(page).to have_content("8")
  end
  # should have a count

  it "should lower the count when used in a recipe" do
    visit recipe_path(@pie)
  end
end