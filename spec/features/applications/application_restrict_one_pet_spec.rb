require 'rails_helper'

RSpec.describe 'Pets can only have one approved application on them at any time' do
  it 'can not approve an application when an application to adopt has been approved already' do
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

    pet_3 = Pet.create( name: 'Abuela',
                        image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/african_hunting_dog_4.jpg',
                        age_approx: 4,
                        sex: 'female',
                        shelter_id: shelter_1.id,
                        breed: 'African Hunting Dog',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')

    # favorite one pet for Danny
    visit "/pets/#{pet_1.id}"
    click_link 'Favorite This Pet'

    # make an application for Danny to apply for favorited pets
    visit '/favorites'
    click_link 'Apply to Adopt Favorited Pets'

    page.check("checkbox-#{pet_1.id}")
    # page.check("checkbox-#{pet_2.id}")
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

    # favorite two pets for Darren
    visit "/pets/#{pet_1.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{pet_2.id}"
    click_link 'Favorite This Pet'

    # make an application for Darren to apply for favorited pets
    visit '/favorites'
    click_link 'Apply to Adopt Favorited Pets'

    page.check("checkbox-#{pet_1.id}")
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

    visit "/applications/#{app_darren.id}"

    within("#pet-#{pet_1.id}") do
      expect(page).to have_content('Already Approved In Other Application')
    end
    within("#pet-#{pet_2.id}") do
      expect(page).to have_link('Approve')
    end
  end
end


# User Story 24, Pets can only have one approved application on them at any time
#
# [ ] done
#
# As a visitor
# When a pet has more than one application made for them
# And one application has already been approved for them
# I can not approve any other applications for that pet but all other applications
# still remain on file (they can be seen on the pets application index page)
# (This can be done by either taking away the option to approve the application,
# or having a flash message pop up saying that no more applications can be approved
# for this pet at this time)
