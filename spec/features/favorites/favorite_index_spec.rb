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

    expect(page).to have_content('Favorited Pets: 2')

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

  it 'can remove a favorite from the favorites page by clicking a delete link next to the favorite' do
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
    visit '/favorites'

    within("#favorite-#{pet_2.id}") do
      click_link 'Remove pet From Favorites'
      expect(current_path).to eq('/favorites')
      # expect(page).to have_content("Favorited Pets: 1")
    end
  end

  it 'can see text on the Favorites index page saying no favorites if no pets have been favorited' do
    visit '/favorites'

    expect(page).to have_content('No pets have been favorited...')
  end

  it 'can remove all favorited pets from the Favorites Page' do
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

    visit '/favorites'

    click_link 'Delete All Favorites'

    expect(page).to_not have_css("#favorite-#{pet_1.id}")
    expect(page).to_not have_css("#favorite-#{pet_2.id}")
  end

  it 'displays a list of pets with approved applications on the favorites index page' do
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

    # favorite one pet for Danny
    visit "/pets/#{pet_1.id}"
    click_link 'Favorite This Pet'

    # make an application for Danny to apply for favorited pets
    visit '/favorites'
    click_link 'Apply to Adopt Favorited Pets'

    page.check("checkbox-#{pet_1.id}")
    fill_in 'Name', with: 'Danny Smith'
    fill_in 'Address', with: '123 Abc Street'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip', with: '80201'
    fill_in 'Phone', with: '123456789'
    fill_in 'Motivation', with: 'Because...'
    click_button 'Submit Application'

    app_danny = Application.last

    visit "/applications/#{app_danny.id}"

    within("#pet-#{pet_1.id}") do
      click_link 'Approve'
    end

    # favorite a pet for Darren
    visit "/pets/#{pet_2.id}"
    click_link 'Favorite This Pet'

    # make an application for Darren to apply for favorited pet
    visit '/favorites'
    click_link 'Apply to Adopt Favorited Pets'

    page.check("checkbox-#{pet_2.id}")
    fill_in 'Name', with: 'Darren Campbell'
    fill_in 'Address', with: '455 Xyq street'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip', with: '80202'
    fill_in 'Phone', with: '123456789'
    fill_in 'Motivation', with: 'I would make a good pet looker afterer'
    click_button 'Submit Application'

    app_darren = Application.last

    visit "/favorites"

    within("#approved-pet-#{pet_1.id}") do
      click_link "#{pet_1.name}"
    end
    expect(current_path).to eq("/pets/#{pet_1.id}")
    visit "/favorites"
    within("#approved-pet-#{pet_1.id}") do
      click_link "#{pet_1.name}"
    end
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end
end


# User Story 37, List of Pets with Approved Applications
#
# [ ] done
#
# As a visitor
# After an application has been approved for one or more pets
# When I visit the favorites page
# I see a section on the page that has a list of all of the pets that have an approved application on them
# Each pet's name is a link to their show page


# User Story 15, Remove all Favorite from Favorites Page
#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link to remove all favorited pets
# When I click that link
# I'm redirected back to the favorites page
# I see the text saying that I have no favorited pets
# And the favorites indicator returns to 0
#
# # User Story 14, No Favorites Page
# #
# # As a visitor
# # When I have not added any pets to my favorites list
# # And I visit my favorites page ("/favorites")
# # I see text saying that I have no favorited pets
#
# # User Story 13, Remove a Favorite from Favorites Page
# #
# # As a visitor
# # When I have added pets to my favorites list
# # And I visit my favorites page ("/favorites")
# # Next to each pet, I see a button or link to remove that pet from my favorites
# # When I click on that button or link to remove a favorite
# # A delete request is sent to "/favorites/:pet_id"
# # And I'm redirected back to the favorites page where I no longer see that pet listed
# And I also see that the favorites indicator has decremented by 1

# User Story 10, Favorite Index Page
#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites index page ("/favorites")
# I see all pets I've favorited
# Each pet in my favorites shows the following information:
# - pet's name (link to pets show page)
# - pet's image
