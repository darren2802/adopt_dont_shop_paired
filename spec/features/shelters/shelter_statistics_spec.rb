require 'rails_helper'

RSpec.describe 'Shelter Pet Count', type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: 'Fontenelle Dog Haven', address: '29 Thomasville Avenue', city: 'Omaha', state: 'Nebraska', zip: 68112)
    @shelter_2 = Shelter.create(name: 'Freeport Dog Shelter', address: '81 Santa Cruz Lane', city: 'Cleveland', state: 'Ohio', zip: 44135)
    @shelter_3 = Shelter.create(name: 'Funkley Dog Haven', address: '29 San Antonio Avenue', city: 'Queens', state: 'New York', zip: 11361)

    @pet_1 = Pet.create(name: 'Larkin', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/redbone_50.jpg', age_approx: 10, sex: 'male', breed: 'Redbone', shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_2 = Pet.create(name: 'Toga', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/bull_mastiff_35.jpg', age_approx: 7, sex: 'female', breed: 'Bull Mastiff', shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_3 = Pet.create(name: 'Juni', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/flat-coated_retriever_117.jpg', age_approx: 13, sex: 'male', breed: 'Flat-Coated Retriever', shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_4 = Pet.create(name: 'Topher', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/scottish_deerhound_95.jpg', age_approx: 5, sex: 'female', breed: 'Scottish Deerhound', shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_5 = Pet.create(name: 'Jiniellyz', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/doberman_147.jpg', age_approx: 8, sex: 'female', breed: 'Doberman', shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_6 = Pet.create(name: 'Cataldi', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/flat-coated_retriever_28.jpg', age_approx: 13, sex: 'male', breed: 'Flat-Coated Retriever', shelter_id: @shelter_2.id,  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end

  it 'counts the number of pets for a shelter when visiting a shelter pet index page' do
    visit "/shelters/#{@shelter_2.id}/pets"
    expect(current_path).to eq("/shelters/#{@shelter_2.id}/pets")

    expect(page).to have_content("Number of pets at this shelter: 6")
  end

  it 'displays the average shelter review rating for a shelter' do
    visit "/shelters/#{@shelter_1.id}"
    # add reviews
    click_link 'Add Review'
    fill_in 'Title', with: 'Shelter well maintained'
    fill_in 'Rating', with: 5
    fill_in 'Content', with: 'Lorem ipsum dolor sit amet'
    fill_in 'Image', with: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg'
    click_on 'Add Review'

    click_link 'Add Review'
    fill_in 'Title', with: 'Shelter well maintained'
    fill_in 'Rating', with: 3
    fill_in 'Content', with: 'Lorem ipsum dolor sit amet'
    fill_in 'Image', with: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg'
    click_on 'Add Review'

    visit "/shelters/#{@shelter_2.id}"
    click_link 'Add Review'
    fill_in 'Title', with: 'Shelter well maintained'
    fill_in 'Rating', with: 4
    fill_in 'Content', with: 'Lorem ipsum dolor sit amet'
    fill_in 'Image', with: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg'
    click_on 'Add Review'

    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Average review rating for this shelter: 4.0")
  end

  it 'displays the number of applications on file for pets of this shelter' do

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

    visit "/shelters/#{@shelter_2.id}"

    expect(page).to have_content("Number of applications on file for pets at this shelter: 2")
  end
end
