class Pet < ApplicationRecord
  validates_presence_of :name, :image, :age_approx, :sex, :breed, :description, :shelter_id
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
end
