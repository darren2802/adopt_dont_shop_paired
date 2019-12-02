require 'rails_helper'

RSpec.describe 'Show Pet', type: :feature do
  before :each do
    @shelter_1 = Shelter.create( name: 'Dog Haven',
                                address: '123 Curtis Street',
                                city: 'Denver',
                                state: 'Colorado',
                                zip: 80202)

    @pet_1 = Pet.create( name: 'Elvis',
                        breed: 'German Shepherd',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/border_collie_92.jpg',
                        age_approx: 7,
                        sex: 'male',
                        adoptable: true,
                        shelter_id: @shelter_1.id)
  end

  it 'can see the individual pet for an id with detailed information' do
    visit "pets/#{@pet_1.id}"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.breed)
    expect(page).to have_content(@pet_1.description)
    expect(page).to have_css("img[src *= 'border_collie_92.jpg']")
    expect(page).to have_content(@pet_1.age_approx)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content('Adoptable')
    expect(page).to have_content(@shelter_1.name)
  end
end
