require 'rails_helper'

describe 'Pet Adoptable Status', type: :feature do
  before :each do
    @shelter_2 = Shelter.create(name: 'Freeport Dog Shelter', address: '81 Santa Cruz Lane', city: 'Cleveland', state: 'Ohio', zip: 44135)

    @pet_1 = Pet.create(name: 'Larkin', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/redbone_50.jpg', age_approx: 10, sex: 'male', breed: 'Redbone', adoptable: true, shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_2 = Pet.create(name: 'Toga', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/bull_mastiff_35.jpg', age_approx: 7, sex: 'female', breed: 'Bull Mastiff', adoptable: false, shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_3 = Pet.create(name: 'Juni', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/flat-coated_retriever_117.jpg', age_approx: 13, sex: 'male', breed: 'Flat-Coated Retriever', adoptable: false, shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_4 = Pet.create(name: 'Topher', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/scottish_deerhound_95.jpg', age_approx: 5, sex: 'female', breed: 'Scottish Deerhound', adoptable: false, shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_5 = Pet.create(name: 'Jiniellyz', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/doberman_147.jpg', age_approx: 8, sex: 'female', breed: 'Doberman', adoptable: true, shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    @pet_6 = Pet.create(name: 'Cataldi', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/flat-coated_retriever_28.jpg', age_approx: 13, sex: 'male', breed: 'Flat-Coated Retriever', adoptable: true, shelter_id: @shelter_2.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end

  it 'shows relevant link for whether pet can be adopted and changes adoptable status on clicking that link to pending' do
    visit "/pets/#{@pet_1.id}"
    expect(current_path).to eq("/pets/#{@pet_1.id}")

    click_on 'Change to Adoption Pending'

    expect(current_path).to eq("/pets")
  end

  it 'shows relevant link for whether pet can be adopted and changes adoptable status on clicking that link to adoptable' do
    visit "/pets/#{@pet_2.id}"
    expect(current_path).to eq("/pets/#{@pet_2.id}")

    click_on 'Change to Adoptable'

    expect(current_path).to eq("/pets")
  end
end
