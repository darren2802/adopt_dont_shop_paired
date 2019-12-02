require 'rails_helper'

RSpec.describe 'Shelter Pet Creation', type: :feature do
  before :each do
    @shelter_1 = Shelter.create( name: 'Dog Haven',
                                address: '123 Curtis Street',
                                city: 'Denver',
                                state: 'Colorado',
                                zip: 80202)
  end
  it 'can add a new adoptable pet when clicking a link on an index page for a shelter' do
    visit "/shelters/#{@shelter_1.id}/pets/new"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")

    fill_in 'Name', with: 'Costello'
    fill_in 'Breed', with: 'German Shepherd'
    fill_in 'Image', with: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/staffordshire_bullterrier_144.jpg'
    fill_in 'Description', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    fill_in 'Age approx', with: 9
    choose 'female'

    click_on 'Add Pet'
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")

    expect(page).to have_content('Costello')
    expect(page).to have_css("img[src *= 'staffordshire_bullterrier_144.jpg']")
    expect(page).to have_content(9)
    expect(page).to have_content('female')
    expect(page).to have_content('Adoptable')
  end
end
