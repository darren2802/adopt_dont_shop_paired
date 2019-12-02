require 'rails_helper'

RSpec.describe 'Pet update', type: :feature do
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
  end
  it 'can edit a pet through a form when clicking update on the show page of an individual pet' do
    visit "/pets/#{@pet_1.id}"
    click_on 'Update'
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

    fill_in 'Image', with: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/german_shepherd_92.jpg'
    fill_in 'Name', with: 'Costello'
    fill_in 'Breed', with: 'German Shepherd'
    fill_in 'Description', with: 'Meet Costello, a German Sheperd 3 years of age.'
    fill_in 'Age approx', with: 3
    fill_in 'Sex', with: 'female'

    click_on 'Save'

    expect(current_path).to eq("/pets/#{@pet_1.id}")

    expect(page).to have_css("img[src *= 'german_shepherd_92.jpg']")
    expect(page).to_not have_css("img[src *= 'border_collie_92.jpg']")

    expect(page).to have_content('Costello')
    expect(page).to_not have_content('Elvis')

    expect(page).to have_content('German Shepherd')
    expect(page).to_not have_content('Border Collie')

    expect(page).to have_content('Meet Costello, a German Sheperd 3 years of age.')
    expect(page).to_not have_content('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')

    expect(page).to have_content(' female')
    expect(page).to_not have_content(' male')

  end
end
