require 'rails_helper'

RSpec.describe 'Shelter Review Creation' do
  describe 'when I visit a shelter show page and click link Create Shelter' do
    before :each do
      @shelter_1 = Shelter.create(name: 'City of the Sun Dog Sanctuary', address: '61 Paxson Street', city: 'Ogden', state: 'Utah', zip: 84404)
    end
    it 'can take me to a new page to add a review for that shelter' do
      visit "/shelters/#{@shelter_1.id}"
      click_link 'Add Review'
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in 'Title', with: 'Shelter well maintained'
      fill_in 'Rating', with: 5
      fill_in 'Content', with: 'Lorem ipsum dolor sit amet'
      fill_in 'Image', with: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg'
      click_on 'Add Review'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      review = Review.last
      within("#review-#{review.id}") do
        expect(page).to have_content('Shelter well maintained')
        expect(page).to have_content(5)
        expect(page).to have_content('Lorem ipsum dolor sit amet')
      end
      within("#review-img-#{review.id}") do
        expect(page).to have_css("img[src *= 'img_shelter_1_german_shepherds.jpg']")
      end
    end
  end
end
