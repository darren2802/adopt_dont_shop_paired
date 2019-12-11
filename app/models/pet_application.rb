class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.pets_data(param_id)
    pets = PetApplication.select('Pets.id, Pets.name, pet_applications.application_approved')
                        .joins(:pet)
                        .where('pet_applications.application_id = ?', param_id)

    pets_data = Hash.new()
    pets.each do |pet|
      pets_data[pet.id] = Hash.new()
      pets_data[pet.id]['name'] = pet.name
      pets_data[pet.id]['application_approved'] = pet.application_approved



      if PetApplication.where('pet_applications.pet_id = ? and pet_applications.application_id != ? and pet_applications.application_approved = true', pet.id, param_id)
                        .count > 0
        pets_data[pet.id]['approved_in_other_app'] = true
      else
        pets_data[pet.id]['approved_in_other_app'] = false
      end
    end
    pets_data
  end

  def self.pet_index_apps(param_id)
    PetApplication.select('Applications.id, Applications.name, Pets.name as pet_name')
                            .joins(:application).joins(:pet)
                            .where('pet_applications.pet_id = ?', param_id)
  end
end
