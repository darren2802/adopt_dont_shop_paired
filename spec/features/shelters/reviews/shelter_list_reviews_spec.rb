require 'rails_helper'

RSpec.describe 'Shelter reviews' do
  before :each do
    @shelter_1 = Shelter.create(name: 'City of the Sun Dog Sanctuary', address: '61 Paxson Street', city: 'Ogden', state: 'Utah', zip: 84404)
    @review_1 = @shelter_1.reviews.create(title: 'Shelter well maintained', rating: 5, content: 'Lorem ipsum dolor sit amet', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg')
    @review_2 = @shelter_1.reviews.create(title: 'Great condition!', rating: 4, content: 'Lorem ipsum dolor sit amet', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_2_shaggy.jpg')
    @review_3 = @shelter_1.reviews.create(title: 'Very neat and tidy.', rating: 5, content: 'Lorem ipsum dolor sit amet')
  end

  it 'can see a list of reviews for that shelter with detailed information for each review' do
    visit "/shelters/#{@shelter_1.id}"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    within("#review-#{@review_1.id}") do
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.rating)
      expect(page).to have_content(@review_1.content)
    end
    within("#review-img-#{@review_1.id}") do
      expect(page).to have_css("img[src *= 'img_shelter_1_german_shepherds.jpg']")
    end

    within("#review-#{@review_2.id}") do
      expect(page).to have_content(@review_2.title)
      expect(page).to have_content(@review_2.rating)
      expect(page).to have_content(@review_2.content)
    end
    within("#review-img-#{@review_2.id}") do
      expect(page).to have_css("img[src *= 'img_shelter_2_shaggy.jpg']")
    end
    within("#review-#{@review_3.id}") do
      expect(page).to have_content(@review_3.title)
      expect(page).to have_content(@review_3.rating)
      expect(page).to have_content(@review_3.content)
    end
  end
end
