class Favorite
  attr_reader :contents

  def initialize(inital_contents)
    @contents = inital_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(pet_id)
    pet_id_str = pet_id.to_s
    @contents[pet_id_str] = count_of(pet_id) +1
  end

  def delete_pet(pet_id)
    pet_id_str = pet_id.to_s
    @contents.delete(pet_id_str)
  end

  def count_of(pet_id)
    @contents[pet_id.to_s].to_i
  end

  def destroy_all
    @contents.clear
  end

  def favorite_pets
    favorite_pets = Hash.new()
    @contents.each_key do |key|
      favorite_pets[key] = Hash.new()
      favorite_pets[key]['name'] = Pet.find(key).name
      favorite_pets[key]['image'] = Pet.find(key).image
    end
    favorite_pets
  end

  def applied_for_pets
    pet_ids = PetApplication.all.distinct.pluck(:pet_id)
    pet_applications = Hash.new()
    pet_ids.each do |pet_id|
      pet_applications[pet_id] = Pet.find(pet_id).name
    end
    pet_applications
  end
end
