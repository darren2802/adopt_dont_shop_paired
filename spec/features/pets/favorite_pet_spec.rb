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
    @fav_pet_1 = Favorite.create
    @fav_pet_2 = Favorite.create
    @fav_pet_3 = Favorite.create
  end
  it 'see favorite indicator in navigation bar' do
    visit("/shelters")
    expect(page).to have_content("Favorites count: 3")

  end
end




#User Story 8, Favorite Indicator

#As a visitor
#I see a favorite indicator in my navigation bar
#The favorite indicator shows a count of pets in my favorites list
#I can see this favorite indicator from any page in the application
