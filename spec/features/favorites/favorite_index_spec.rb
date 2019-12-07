require 'rails_helper'

RSpec.describe 'Favorite Index Page' do
  it 'can see all pets favorited and their name (link to show page) and image when visiting the index page (/favorites)' do
    shelter_1 = Shelter.create( name: 'Dog Haven',
                                address: '123 Curtis Street',
                                city: 'Denver',
                                state: 'Colorado',
                                zip: 80202)

    pet_1 = Pet.create( name: 'Elvis',
                        image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/border_collie_92.jpg',
                        age_approx: 7,
                        sex: 'male',
                        breed: 'Border Collie',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        shelter_id: shelter_1.id)

    pet_2 = Pet.create( name: 'Costello',
                        image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/african_hunting_dog_29.jpg',
                        age_approx: 10,
                        sex: 'male',
                        shelter_id: shelter_1.id,
                        breed: 'German Shepherd',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')

    visit "/pets/#{pet_1.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{pet_2.id}"
    click_link 'Favorite This Pet'

    expect(page).to have_content('Favorites count: 2')

    visit '/favorites'

    within("#favorite-#{pet_1.id}") do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_link(pet_1.name)
      expect(page).to have_css("img[src *= 'border_collie_92.jpg']")
    end
    within("#favorite-#{pet_2.id}") do
      expect(page).to have_content(pet_2.name)
      expect(page).to have_link(pet_2.name)
      expect(page).to have_css("img[src *= 'african_hunting_dog_29.jpg']")
    end
  end
end


# User Story 10, Favorite Index Page
#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites index page ("/favorites")
# I see all pets I've favorited
# Each pet in my favorites shows the following information:
# - pet's name (link to pets show page)
# - pet's image
