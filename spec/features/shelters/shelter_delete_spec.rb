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

      click_link 'Delete'

      expect(current_path).to eq('/shelters')
      expect(page).to have_content("#{shelter_1.name} has been deleted.")
    end

    it 'can not delete a shelter if that shelter has pets with pending status' do
      shelter_1 = Shelter.create( name: 'Dog Haven',
                                  address: '123 Curtis Street',
                                  city: 'Denver',
                                  state: 'Colorado',
                                  zip: 80202)

      pet_1 = Pet.create( name: 'Elvis',
                          image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/border_collie_92.jpg',
                          age_approx: 7,
                          sex: 'male',
                          breed: 'Border Collie',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                          shelter_id: shelter_1.id)

      pet_2 = Pet.create( name: 'Costello',
                          image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/african_hunting_dog_29.jpg',
                          age_approx: 10,
                          sex: 'male',
                          shelter_id: shelter_1.id,
                          breed: 'German Shepherd',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')

      # favorite the pets
      visit "/pets/#{pet_1.id}"
      click_link 'Favorite This Pet'
      visit "/pets/#{pet_2.id}"
      click_link 'Favorite This Pet'

      # go to the Favorites page and make an application for Danny to apply for favorited pets
      visit '/favorites'
      click_link 'Apply to Adopt Favorited Pets'

      page.check("checkbox-#{pet_1.id}")
      page.check("checkbox-#{pet_2.id}")
      fill_in 'Name', with: 'Danny Smith'
      fill_in 'Address', with: '123 Abc Street'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '80201'
      fill_in 'Phone', with: '123456789'
      fill_in 'Motivation', with: 'Because...'
      click_button 'Submit Application'

      app = Application.last

      visit "/applications/#{app.id}"

      within("#pet-#{pet_1.id}") do
        click_link 'Approve'
      end

      visit '/shelters'

      click_link 'Delete'

      expect(page).to have_content("#{shelter_1.name} cannot be deleted as it has pets with approved applications (status pending). Please revoke the applications first.")
    end

    it 'can delete a shelter if that shelter has no pets with pending status' do
      shelter_1 = Shelter.create( name: 'Dog Haven',
                                  address: '123 Curtis Street',
                                  city: 'Denver',
                                  state: 'Colorado',
                                  zip: 80202)

      pet_1 = Pet.create( name: 'Elvis',
                          image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/border_collie_92.jpg',
                          age_approx: 7,
                          sex: 'male',
                          breed: 'Border Collie',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                          shelter_id: shelter_1.id)

      pet_2 = Pet.create( name: 'Costello',
                          image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/african_hunting_dog_29.jpg',
                          age_approx: 10,
                          sex: 'male',
                          shelter_id: shelter_1.id,
                          breed: 'German Shepherd',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')

      # favorite the pets
      visit "/pets/#{pet_1.id}"
      click_link 'Favorite This Pet'
      visit "/pets/#{pet_2.id}"
      click_link 'Favorite This Pet'

      # go to the Favorites page and make an application for Danny to apply for favorited pets
      visit '/favorites'
      click_link 'Apply to Adopt Favorited Pets'

      page.check("checkbox-#{pet_1.id}")
      page.check("checkbox-#{pet_2.id}")
      fill_in 'Name', with: 'Danny Smith'
      fill_in 'Address', with: '123 Abc Street'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '80201'
      fill_in 'Phone', with: '123456789'
      fill_in 'Motivation', with: 'Because...'
      click_button 'Submit Application'

      visit '/shelters'

      click_link 'Delete'

      expect(page).to have_content("#{shelter_1.name} has been deleted.")
    end

    it 'can delete reviews for a shelter when the shelter is deleted' do
      shelter_1 = Shelter.create( name: 'Dog Haven',
                                  address: '123 Curtis Street',
                                  city: 'Denver',
                                  state: 'Colorado',
                                  zip: 80202)

      pet_1 = Pet.create( name: 'Elvis',
                          image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/border_collie_92.jpg',
                          age_approx: 7,
                          sex: 'male',
                          breed: 'Border Collie',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                          shelter_id: shelter_1.id)

      visit "/shelters/#{shelter_1.id}"
      click_link 'Add Review'
      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

      fill_in 'Title', with: 'Shelter well maintained'
      fill_in 'Rating', with: 5
      fill_in 'Content', with: 'Lorem ipsum dolor sit amet'
      fill_in 'Image', with: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg'
      click_on 'Add Review'

      review = Review.last
      within("#review-#{review.id}") do
        expect(page).to have_content('Shelter well maintained')
        expect(page).to have_content(5)
        expect(page).to have_content('Lorem ipsum dolor sit amet')
        expect(page).to have_css("img[src *= 'img_shelter_1_german_shepherds.jpg']")
      end

      visit '/shelters'

      click_link 'Delete'
    end
  end
end

# User Story 28, Deleting Shelters Deletes its Reviews
#
# As a visitor
# When I delete a shelter
# All reviews associated with that shelter are also deleted

# User Story 27, Shelters can be Deleted as long as all pets do not have approved applications on them
#
# As a visitor
# If a shelter doesn't have any pets with a pending status
# I can delete that shelter
# When that shelter is deleted
# Then all of their pets are deleted as well

# User Story 26, Shelters with Pets that have pending status cannot be Deleted
#
# As a visitor
# If a shelter has approved applications for any of their pets
# I can not delete that shelter
# Either:
# - there is no button visible for me to delete the shelter
# - if I click on the delete link for deleting a shelter, I see a flash message
# indicating that the shelter can not be deleted.
