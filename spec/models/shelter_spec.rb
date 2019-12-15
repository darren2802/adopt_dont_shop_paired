require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it {should have_many :pets}
  end

  describe "methods" do
    before :each do
      @shelter_1 = Shelter.create(name: 'City of the Sun Dog Sanctuary', address: '61 Paxson Street', city: 'Ogden', state: 'Utah', zip: 84404)
      @review_1 = @shelter_1.reviews.create(title: 'Shelter well maintained', rating: 5, content: 'Lorem ipsum dolor sit amet', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg')
      @review_2 = @shelter_1.reviews.create(title: 'Great condition!', rating: 4, content: 'Lorem ipsum dolor sit amet', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_2_shaggy.jpg')
      @review_3 = @shelter_1.reviews.create(title: 'Very neat and tidy.', rating: 5, content: 'Lorem ipsum dolor sit amet')
      @pet_1 = Pet.create( name: 'Elvis',
                          image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/border_collie_92.jpg',
                          age_approx: 7,
                          sex: 'male',
                          breed: 'Border Collie',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                          shelter_id: @shelter_1.id)

      @pet_2 = Pet.create( name: 'Costello',
                          image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/african_hunting_dog_29.jpg',
                          age_approx: 10,
                          sex: 'male',
                          shelter_id: @shelter_1.id,
                          breed: 'German Shepherd',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
      @application_1 = Application.create(  name:'Danny Smith',
                                            address:'123 Abc Street',
                                            city:'Denver',
                                            state:'Colorado',
                                            zip:'80201',
                                            phone:'123456789',
                                            motivation:'Because...')
      @application_2 = Application.create(  name:'Darren Campbell',
                                            address:'455 Xyq street',
                                            city:'Denver',
                                            state:'Colorado',
                                            zip:'80202',
                                            phone:'123456789',
                                            motivation:'I would make a good pet looker afterer')
    end

    it "can return an average review rating" do
      expect(@shelter_1.average_review_rating.round(1)).to eq(4.7)
    end

    it "can return the number of applications for pets at this shelter" do
      @application_1.pets << @pet_1
      @application_2.pets << @pet_2
      expect(@shelter_1.number_applications).to eq(2)
    end
  end
end
