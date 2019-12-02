require 'rails_helper'

RSpec.describe 'shelters', type: :feature do
  it 'can see shelter index' do
    shelter_1 = Shelter.create( name: 'Dog Haven',
                                address: '123 Curtis Street',
                                city: 'Denver',
                                state: 'Colorado',
                                zip: 80202)
    shelter_2 = Shelter.create( name: 'Dog Shelter',
                                address: '456 Arapahoe Street',
                                city: 'Denver',
                                state: 'Colorado',
                                zip: 80201)
    shelter_3 = Shelter.create( name: 'Dog Home',
                                address: '789 Blake Street',
                                city: 'Denver',
                                state: 'Colorado',
                                zip: 80203)

    visit '/shelters'

    expect(page).to have_content('Dog Haven')
    expect(page).to have_content('Dog Shelter')
    expect(page).to have_content('Dog Home')
  end
end
