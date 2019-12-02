require 'rails_helper'

RSpec.describe 'New shelter' do
  describe 'When I visit the new shelter form by clicking a link on the index' do
    it 'creates a new shelter' do
      visit '/shelters'

      click_link 'Add Shelter'

      expect(current_path).to eq('/shelters/new')

      fill_in 'Name', with: 'Denver'
      fill_in 'Address', with: '123 Blake Street'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '80201'

      click_on 'Add Shelter'
      expect(current_path).to eq('/shelters')
      expect(page).to have_content('Denver')
    end
  end
end
