require 'rails_helper'
RSpec.describe 'Applying for a pet' do
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

    @pet_3 = Pet.create( name: 'Abuela',
                        image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/african_hunting_dog_4.jpg',
                        age_approx: 4,
                        sex: 'female',
                        shelter_id: @shelter_1.id,
                        breed: 'African Hunting Dog',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end

  it 'see a list of all pets with applications' do

    visit "/pets/#{@pet_1.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{@pet_2.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{@pet_3.id}"
    click_link 'Favorite This Pet'

    visit '/favorites'
    click_link 'Apply to Adopt Favorited Pets'

    page.check("checkbox-#{@pet_1.id}")
    page.check("checkbox-#{@pet_2.id}")

    fill_in 'Name', with: 'Danny'
    fill_in 'Address', with: '123 Abc Street'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip', with: '80201'
    fill_in 'Phone', with: '123456789'
    fill_in 'Motivation', with: 'Because...'

    click_button 'Submit Application'

    within("#pets_applied_for") do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      click_link @pet_1.name
      expect(current_path).to eq("/pets/#{@pet_1.id}")
      visit "/favorites"
      click_link @pet_2.name
      expect(current_path).to eq("/pets/#{@pet_2.id}")
    end
  end
end


# User Story 18, List of Pets that have applications on them
#
# As a visitor
# After one or more applications have been created
# When I visit the favorites index page
# I see a section on the page that has a list of all of the pets that have at least one application on them
# Each pet's name is a link to their show page
