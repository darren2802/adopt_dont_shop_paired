require 'rails_helper'

RSpec.describe 'Approve An Applications for Multiple Pets' do
  it 'can approve applications for specific pets on an application show page and then redirects to the pet show page where status changes to pending' do
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

    # favorite the pets
    visit "/pets/#{pet_1.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{pet_2.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{pet_3.id}"
    click_link 'Favorite This Pet'

    # go to the Favorites page and make an application for Danny to apply for favorited pets
    visit '/favorites'
    click_link 'Apply to Adopt Favorited Pets'

    page.check("checkbox-#{pet_1.id}")
    page.check("checkbox-#{pet_2.id}")
    fill_in 'Name', with: 'Danny Smith'
    fill_in 'Address', with: '123 Abc Street'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip', with: '80201'
    fill_in 'Phone', with: '123456789'
    fill_in 'Motivation', with: 'Because...'
    click_button 'Submit Application'

    app = Application.last

    visit "/applications/#{app.id}"

    within("#pet-#{pet_1.id}") do
      click_link 'Approve'
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content('Application Pending')
    expect(page).to have_content("On Hold For: #{app.name}")

    visit "/applications/#{app.id}"

    within("#pet-#{pet_2.id}") do
      click_link 'Approve'
    end

    expect(current_path).to eq("/pets/#{pet_2.id}")
    expect(page).to have_content('Application Pending')
    expect(page).to have_content("On Hold For: #{app.name}")

    visit "/applications/#{app.id}"

    within("#pet-#{pet_1.id}") do
      expect(page).to have_link('Revoke')
    end

    within("#pet-#{pet_2.id}") do
      expect(page).to have_link('Revoke')
    end
  end
end

# User Story 23, Users can get approved to adopt more than one pet
#
# As a visitor
# When an application is made for more than one pet
# When I visit that applications show page
# I'm able to approve the application for any number of pets
