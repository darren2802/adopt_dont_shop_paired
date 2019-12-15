require 'rails_helper'

RSpec.describe 'Breeds Show page' do
  it 'can click a breed at /breeds and be taken to a show page displaying all pets for that breed' do
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

    visit '/breeds'
    click_link 'Border Collies'
    expect(current_path).to eq('/breeds/border_collies')

    expect(page).to have_content(pet_1.name)
    expect(page).to have_css("img[src *= 'border_collie_92.jpg']")
    expect(page).to have_content(pet_1.age_approx)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(shelter_1.name)

    visit '/breeds'
    click_link 'German Shepherds'
    expect(current_path).to eq('/breeds/german_shepherds')

    expect(page).to have_content(pet_2.name)
    expect(page).to have_css("img[src *= 'african_hunting_dog_29.jpg']")
    expect(page).to have_content(pet_2.age_approx)
    expect(page).to have_content(pet_2.sex)
    expect(page).to have_content(shelter_1.name)
  end
end
