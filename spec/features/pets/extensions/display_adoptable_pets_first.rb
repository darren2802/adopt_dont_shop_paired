require 'rails_helper'

RSpec.describe 'Display Adoptable Pets First', type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: 'Fontenelle Dog Haven', address: '29 Thomasville Avenue', city: 'Omaha', state: 'Nebraska', zip: 68112)
    @shelter_2 = Shelter.create(name: 'Freeport Dog Shelter', address: '81 Santa Cruz Lane', city: 'Cleveland', state: 'Ohio', zip: 44135)
    @shelter_3 = Shelter.create(name: 'Funkley Dog Haven', address: '29 San Antonio Avenue', city: 'Queens', state: 'New York', zip: 11361)

    @pet_1 = Pet.create(name: 'Larkin', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/redbone_50.jpg', age_approx: 10, sex: 'male', breed: 'Redbone', adoptable: true, shelter_id: @shelter_2.id)
    @pet_2 = Pet.create(name: 'Toga', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/bull_mastiff_35.jpg', age_approx: 7, sex: 'female', breed: 'Bull Mastiff', adoptable: false, shelter_id: @shelter_2.id)
    @pet_3 = Pet.create(name: 'Juni', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/flat-coated_retriever_117.jpg', age_approx: 13, sex: 'male', breed: 'Flat-Coated Retriever', adoptable: false, shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(name: 'Topher', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/scottish_deerhound_95.jpg', age_approx: 5, sex: 'female', breed: 'Scottish Deerhound', adoptable: false, shelter_id: @shelter_2.id)
    @pet_5 = Pet.create(name: 'Jiniellyz', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/doberman_147.jpg', age_approx: 8, sex: 'female', breed: 'Doberman', adoptable: true, shelter_id: @shelter_2.id)
    @pet_6 = Pet.create(name: 'Cataldi', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/flat-coated_retriever_28.jpg', age_approx: 13, sex: 'male', breed: 'Flat-Coated Retriever', adoptable: true, shelter_id: @shelter_2.id)
  end

  let!(:ordered_1) { @pet_1 }
  let!(:ordered_2) { @pet_5 }
  let!(:ordered_3) { @pet_6 }
  let!(:ordered_4) { @pet_2 }
  let!(:ordered_5) { @pet_3 }
  let!(:ordered_6) { @pet_4 }

  it 'shows adoptable pets first when visiting the pets index page' do
    visit "/pets"
    expect(current_path).to eq("/pets")

    page.body.index(ordered_2).should < page.body.index(ordered_4)
  end
end



# RSpec::Matchers.define :appear_before do |later_content|
#   match do |earlier_content|
#     page.body.index(earlier_content) < page.body.index(later_content)
#   end
# end
