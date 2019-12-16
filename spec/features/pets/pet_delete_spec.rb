require 'rails_helper'

RSpec.describe 'Delete Pet', type: :feature do
  before :each do
    @shelter_1 = Shelter.create( name: 'Dog Haven',
                                address: '123 Curtis Street',
                                city: 'Denver',
                                state: 'Colorado',
                                zip: 80202)

    @pet_1 = Pet.create( name: 'Elvis',
                        image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/border_collie_92.jpg',
                        age_approx: 7,
                        sex: 'female',
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
                        sex: 'male',
                        shelter_id: @shelter_1.id,
                        breed: 'African Hunting Dog',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')

  end
  it 'can delete a pet when clicking on Delete on a show pet page' do
    visit "/pets/#{@pet_1.id}"
    click_link 'Delete'
    expect(current_path).to eq("/pets")

    expect(page).to_not have_content('Elvis')
    expect(page).to_not have_css("img[src *='border_collie_92.jpg']")
    expect(page).to_not have_content(7)
    expect(page).to_not have_content('female')
    expect(page).to_not have_content('Border Collie')
    expect(page).to_not have_content('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end

  it 'can not delete a pet that has approved applications' do
    # favorite the pets
    visit "/pets/#{@pet_1.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{@pet_2.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{@pet_3.id}"
    click_link 'Favorite This Pet'

    # go to the Favorites page and make an application for Danny to apply for favorited pets
    visit '/favorites'
    click_link 'Apply to Adopt Favorited Pets'

    page.check("checkbox-#{@pet_1.id}")
    page.check("checkbox-#{@pet_2.id}")
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

    within("#pet-#{@pet_1.id}") do
      click_link 'Approve'
    end

    visit "/pets/#{@pet_1.id}"
    click_link 'Delete'
    expect(current_path).to eq("/pets/#{@pet_1.id}/")
    expect(page).to have_content("#{@pet_1.name} has an approved application and cannot be deleted.")
  end

  it 'can remove a pet from favorites when it is deleted' do
    visit "/pets/#{@pet_1.id}"
    click_link 'Favorite This Pet'
    visit '/favorites'

    within("#favorite-#{@pet_1.id}") do
      expect(page).to have_content('Elvis')
    end

    visit "/pets/#{@pet_1.id}"
    click_link 'Delete'

    visit '/favorites'
    expect(page).to_not have_css("#favorite-#{@pet_1.id}")
  end
end


# User Story 31, Pets with approved applications cannot be deleted
#
# As a visitor
# If a pet has an approved application on them
# I can not delete that pet
# Either:
# - there is no button visible for me to delete the pet
# - if I click on the delete button, I see a flash message indicating that the
#   pet can not be deleted.
