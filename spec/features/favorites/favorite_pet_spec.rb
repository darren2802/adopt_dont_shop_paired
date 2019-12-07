require 'rails_helper'

RSpec.describe 'favorite Pet', type: :feature do
  before :each do
    @shelter_1 = Shelter.create( name: 'Dog Haven',
                                address: '123 Curtis Street',
                                city: 'Denver',
                                state: 'Colorado',
                                zip: 80202)

    @pet_1 = Pet.create( name: 'Elvis',
                        image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/border_collie_92.jpg',
                        age_approx: 7,
                        sex: 'male',
                        breed: 'Border Collie',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        shelter_id: @shelter_1.id)

      @pet_2 = Pet.create( name: 'Costello',
                        image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/african_hunting_dog_29.jpg',
                        age_approx: 10,
                        sex: 'male',
                        shelter_id: @shelter_1.id,
                        breed: 'German Shepherd',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')

  end
  it 'see favorite indicator in navigation bar' do
    visit("/shelters")
    expect(page).to have_content("Favorited Pets: 0")

  end

  it 'see a button or link to favorite that pet' do
    visit("/pets/#{@pet_1.id}")

    click_link 'Favorite This Pet'

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("#{@pet_1.name} has been added to Favorites")
    expect(page).to have_content("Favorited Pets: 1")

  end

  # it 'favorite indicator in navigation bar directs to favorites index page' do
  #   visit("/pets/#{@pet_1.id}")
  #
  #   click_link 'Favorite This Pet'
  #   binding.pry
  #   click_link "Favorited Pets: 3"
  #   binding.pry
  #   expect(current_path).to eq("/favorites")
  # end
end

# As a visitor
# When I click on the favorite indicator in the nav bar
# I am taken to the favorites index page

# As a visitor
# When I visit a pet's show page
# I see a button or link to favorite that pet
# When I click the button or link
# I'm taken back to that pet's show page
# I see a flash message indicating that the pet has been added to my favorites list
# The favorite indicator in the nav bar has incremented
