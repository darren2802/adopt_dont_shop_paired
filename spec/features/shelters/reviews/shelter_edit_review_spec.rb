require 'rails_helper'

RSpec.describe 'Edit a Shelter' do
  it 'can edit a shelter review via a form reached by clicking an edit link on a shelter show page' do
    shelter_1 = Shelter.create(name: 'City of the Sun Dog Sanctuary', address: '61 Paxson Street', city: 'Ogden', state: 'Utah', zip: 84404)
    review_1 = shelter_1.reviews.create(title: 'Shelter well maintained', rating: 5, content: 'Lorem ipsum dolor sit amet', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg')
    review_2 = shelter_1.reviews.create(title: 'Great condition!', rating: 4, content: 'Lorem ipsum dolor sit amet', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_2_shaggy.jpg')
    review_3 = shelter_1.reviews.create(title: 'Very neat and tidy.', rating: 5, content: 'Lorem ipsum dolor sit amet')

    visit "/shelters/#{shelter_1.id}"

    within("#review-#{review_2.id}") do
      click_link 'Edit'
    end
    expect(current_path).to eq("/reviews/#{review_2.id}/edit")

    expect(page).to have_selector("input[value='Great condition!']")
    expect(page).to have_selector("input[value='4']")
    expect(page).to have_selector("input[value='Lorem ipsum dolor sit amet']")
    expect(page).to have_selector("input[value='https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_2_shaggy.jpg']")

    fill_in 'Title', with: 'Poor condition'
    fill_in 'Rating', with: 2
    fill_in 'Content', with: 'Needs immediate attention'
    fill_in 'Image', with: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg'

    click_on 'Save Changes'

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content('Poor condition')
    expect(page).to have_content(2)
    expect(page).to have_content('Needs immediate attention')
    expect(page).to have_css("img[src *= 'img_shelter_1_german_shepherds.jpg']")
  end
end
