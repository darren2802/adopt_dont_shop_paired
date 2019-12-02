class Pet < ApplicationRecord
  validates_presence_of :name, :image, :age_approx, :sex, :breed, :description, :shelter_id
  belongs_to :shelter
end
