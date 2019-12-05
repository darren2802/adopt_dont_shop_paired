require 'rails_helper'

RSpec.describe 'Shelter Review Creation sad path' do
  it 'shows a flash message when trying to submit an incomplete message' do
    shelter_1 = Shelter.create(name: 'City of the Sun Dog Sanctuary', address: '61 Paxson Street', city: 'Ogden', state: 'Utah', zip: 84404)

    visit "/shelters/#{shelter_1.id}"
    click_link 'Add Review'
    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

    fill_in 'Title', with: 'Decent shelter'
    fill_in 'Content', with: 'Lorem ipsum dolor sit amet'
    fill_in 'Image', with: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg'
    click_on 'Add Review'

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
    expect(page).to have_content('Incomplete review submitted, please try again.')

    fill_in 'Title', with: 'Decent shelter'
    fill_in 'Rating', with: 5
    fill_in 'Content', with: 'Lorem ipsum dolor sit amet'
    fill_in 'Image', with: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg'
    click_on 'Add Review'

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content('Decent shelter')
    expect(page).to have_content(5)
    expect(page).to have_content('Lorem ipsum dolor sit amet')
    expect(page).to have_css("img[src *= 'img_shelter_1_german_shepherds.jpg']")
  end
end
