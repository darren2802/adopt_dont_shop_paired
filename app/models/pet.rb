class Pet < ApplicationRecord
  validates_presence_of :name, :image, :age_approx, :sex, :breed, :description, :shelter_id
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def reserved_for
    PetApplication.select('applications.name')
                          .joins(:application)
                          .where('pet_applications.pet_id = ? and pet_applications.application_approved = true',id)
                          .pluck(:name)[0]
  end

  def application_approved
    PetApplication.select('applications.id, applications.name')
                  .joins(:application)
                  .where('pet_applications.pet_id = ? and pet_applications.application_approved = true',id)
  end
end
