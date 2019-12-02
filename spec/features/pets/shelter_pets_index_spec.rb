require 'rails_helper'

RSpec.describe 'Shelter pets index', type: :feature do
  before :each do
    @shelter_1 = Shelter.create( name: 'Dog Haven',
                                address: '123 Curtis Street',
                                city: 'Denver',
                                state: 'Colorado',
                                zip: 80202)
    @shelter_2 = Shelter.create( name: 'Dog Sanctuary',
                                address: '456 Blake Street',
                                city: 'Denver',
                                state: 'Colorado',
                                zip: 80201)

    @pet_1 = Pet.create( name: 'Elvis',
                        image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/border_collie_92.jpg',
                        age_approx: 7,
                        sex: 'female',
                        shelter_id: @shelter_1.id,
                        breed: 'African Hunting Dog',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_2 = Pet.create( name: 'Costello',
                        image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/african_hunting_dog_29.jpg',
                        age_approx: 10,
                        sex: 'male',
                        shelter_id: @shelter_2.id,
                        breed: 'German Shepherd',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end

  it 'can see each pet available for adoption for a specific shelter' do
    visit "/shelters/#{@shelter_2.id}/pets"

    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.age_approx)
    expect(page).to have_content(@pet_2.sex)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_css("img[src *= 'african_hunting_dog_29.jpg']")

    expect(page).to_not have_content(@pet_1.name)
    expect(page).to_not have_content(@pet_1.age_approx)
    expect(page).to_not have_content(@pet_1.sex)
    expect(page).to_not have_content(@shelter_1.name)
    expect(page).to_not have_css("img[src *= 'border_collie_92.jpg']")

  end
end
