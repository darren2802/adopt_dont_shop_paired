require 'rails_helper'

RSpec.describe 'Applying for a pet' do
  it 'can apply to adopt pets that have been favorited' do
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

    visit "/pets/#{pet_1.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{pet_2.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{pet_3.id}"
    click_link 'Favorite This Pet'

    visit '/favorites'
    click_link 'Apply to Adopt Favorited Pets'

    expect(current_path).to eq('/favorites/application')

    within("#favorited_pets-#{pet_1.id}") do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_field("checkbox-#{pet_1.id}", checked: false)
    end
    within("#favorited_pets-#{pet_2.id}") do
      expect(page).to have_content(pet_2.name)
      expect(page).to have_field("checkbox-#{pet_2.id}", checked: false)
    end
    within("#favorited_pets-#{pet_3.id}") do
      expect(page).to have_content(pet_3.name)
      expect(page).to have_field("checkbox-#{pet_3.id}", checked: false)
    end

    page.check("checkbox-#{pet_1.id}")
    page.check("checkbox-#{pet_2.id}")

    expect(page).to have_field("checkbox-#{pet_1.id}", checked: true)
    expect(page).to have_field("checkbox-#{pet_2.id}", checked: true)
    expect(page).to have_field("checkbox-#{pet_3.id}", checked: false)

    fill_in 'Name', with: 'Danny'
    fill_in 'Address', with: '123 Abc Street'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip', with: '80201'
    fill_in 'Phone', with: '123456789'
    fill_in 'Motivation', with: 'Because...'

    click_button 'Submit Application'

    expect(current_path).to eq('/favorites')

    expect(page).to have_content('Thank you for applying to adopt')

    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)

  end
end


# User Story 16, Applying for a Pet
#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link for adopting my favorited pets
# When I click that link I'm taken to a new application form
# At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
# When I select one or more pets, and fill in my
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I see a flash message indicating my application went through for the pets that were selected
# And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites
