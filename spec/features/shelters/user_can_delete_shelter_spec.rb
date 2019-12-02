require 'rails_helper'

RSpec.describe 'Delete shelter' do
  describe 'When I click the delete link next to a shelter on the shelter index page' do
    it 'deletes the shelter' do
      shelter_1 = Shelter.create( name: 'Dog Haven',
                                  address: '123 Curtis Street',
                                  city: 'Denver',
                                  state: 'Colorado',
                                  zip: 80202)

      visit '/shelters'

      click_on 'Delete'

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(shelter_1.name)
    end
  end
end
