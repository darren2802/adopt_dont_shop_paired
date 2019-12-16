class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets
  has_many :reviews

  def average_review_rating
    Review.where('shelter_id = ?', id).average(:rating)
  end

  def number_applications
    PetApplication.joins(:pet).where('pets.shelter_id = ?', id).count
  end

  def number_pets
    self.pets.count
  end
end
