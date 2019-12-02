require 'rails_helper'

RSpec.describe 'Update shelter' do
  describe 'When I visit the update shelter form by clicking a link in the shelter index' do
    it 'updates the shelter' do
      shelter_1 = Shelter.create( name: 'Dog Haven',
                                  address: '123 Curtis Street',
                                  city: 'Denver',
                                  state: 'Colorado',
                                  zip: 80202)

      visit 'shelters'

      click_on 'Edit'

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

      fill_in 'Name', with: 'Dog Sanctuary'
      fill_in 'Address', with: '456 Blake Street'
      fill_in 'City', with: 'Cheyenne'
      fill_in 'State', with: 'Wyoming'
      fill_in 'Zip', with: 50201
      click_on 'Update Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).to have_content('Dog Sanctuary')
      expect(page).to_not have_content('Dog Haven')

      click_on 'Dog Sanctuary'

      expect(page).to have_content('456 Blake Street')
      expect(page).to_not have_content('123 Curtis Street')
      expect(page).to have_content('Cheyenne')
      expect(page).to_not have_content('Denver')
      expect(page).to have_content('Wyoming')
      expect(page).to_not have_content('Colorado')
      expect(page).to have_content(50201)
      expect(page).to_not have_content(80202)
    end
  end
end
