require 'rails_helper'

RSpec.describe 'Shelter Review Delete' do
  it 'can delete a shelter review by clicking a delete link on a shelter show page' do
    shelter_1 = Shelter.create(name: 'City of the Sun Dog Sanctuary', address: '61 Paxson Street', city: 'Ogden', state: 'Utah', zip: 84404)
    review_1 = shelter_1.reviews.create(title: 'Shelter well maintained', rating: 5, content: 'Lorem ipsum dolor sit amet', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg')
    review_2 = shelter_1.reviews.create(title: 'Great condition!', rating: 4, content: 'Lorem ipsum dolor sit amet for this', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_2_shaggy.jpg')
    review_3 = shelter_1.reviews.create(title: 'Very neat and tidy.', rating: 5, content: 'Lorem ipsum dolor sit amet')

    visit "/shelters/#{shelter_1.id}"
    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    within("#review-#{review_2.id}") do
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.rating)
      expect(page).to have_content(review_2.content)
      expect(page).to have_css("img[src *= 'img_shelter_2_shaggy.jpg']")

      click_link 'Delete Review'
    end

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    expect(page).to_not have_css("#review-#{review_2.id}")
    expect(page).to_not have_content(review_2.title)
    # expect(page).to_not have_content(review_2.rating)
    expect(page).to_not have_content(review_2.content)
    expect(page).to_not have_css("img[src *= 'img_shelter_2_shaggy.jpg']")
  end
end
