require 'rails_helper'

RSpec.describe 'New shelter' do
  describe 'When I visit the new shelter form by clicking a link on the index' do
    it 'creates a new shelter' do
      visit '/shelters'

      click_link 'Add Shelter'

      expect(current_path).to eq('/shelters/new')

      fill_in 'Name', with: 'Denver Haven'
      fill_in 'Address', with: '123 Blake Street'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '80201'

      click_button 'Add Shelter'
      expect(current_path).to eq('/shelters')
      shelter = Shelter.last
      expect(page).to have_content(shelter.name)

      expect(page).to have_content("#{shelter.name} has been created.")
    end

    it 'generates a flash message indicating missing fields if form is incomplete' do
      visit '/shelters'

      click_link 'Add Shelter'

      expect(current_path).to eq('/shelters/new')

      fill_in 'Name', with: 'Denver Haven'
      fill_in 'Address', with: '123 Blake Street'
      # fill_in 'City', with: 'Denver'
      # fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '80201'

      click_on 'Add Shelter'
      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content('Denver Haven')

      expect(page).to have_content("Shelter not created due to incomplete fields, please try again.")
    end
  end
end
