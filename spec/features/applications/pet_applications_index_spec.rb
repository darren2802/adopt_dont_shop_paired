require 'rails_helper'

RSpec.describe 'Pet Applications Index Page' do
  it 'can show the details of an individual application when visiting /applications/:id' do
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

    # favorite the pet
    visit "/pets/#{pet_1.id}"
    click_link 'Favorite This Pet'

    # go to the Favorites page and make an application for Danny to apply for favorited pets
    visit '/favorites'
    click_link 'Apply to Adopt Favorited Pets'

    page.check("checkbox-#{pet_1.id}")
    fill_in 'Name', with: 'Danny'
    fill_in 'Address', with: '123 Abc Street'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip', with: '80201'
    fill_in 'Phone', with: '123456789'
    fill_in 'Motivation', with: 'Because...'
    click_button 'Submit Application'

    app_danny = Application.last

    #favorite the 3 pets again so they can be applied for by Darren
    visit "/pets/#{pet_1.id}"
    click_link 'Favorite This Pet'

    #go to the Favorites page and make an application for Darren to apply for favorited pets
    visit '/favorites'
    click_link 'Apply to Adopt Favorited Pets'

    page.check("checkbox-#{pet_1.id}")
    fill_in 'Name', with: 'Darren'
    fill_in 'Address', with: '456 Xyz Street'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip', with: '80202'
    fill_in 'Phone', with: '123456789'
    fill_in 'Motivation', with: 'Because...'
    click_button 'Submit Application'

    app_darren = Application.last

    visit "/pets/#{pet_1.id}"

    click_link 'Applications For This Pet'
    expect(current_path).to eq("/pets/#{pet_1.id}/applications")

    click_link 'Danny'
    expect(current_path).to eq("/applications/#{app_danny.id}")

    visit "/pets/#{pet_1.id}"

    click_link 'Applications For This Pet'
    expect(current_path).to eq("/pets/#{pet_1.id}/applications")

    click_link 'Darren'
    expect(current_path).to eq("/applications/#{app_darren.id}")
  end

  it 'sees a message indicating no pets have been applied for when visiting a pet applications index page' do
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
    visit "/pets/#{pet_1.id}"
    click_link 'Applications For This Pet'
    expect(page).to have_content('This pet has no applications for adoption')
  end
end
