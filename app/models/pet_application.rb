class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.pets_data(param_id)
    PetApplication.select('Pets.id, Pets.name, Pets.application_approved')
                        .joins(:pet)
                        .where('pet_applications.application_id = ?', param_id)
  end
end
