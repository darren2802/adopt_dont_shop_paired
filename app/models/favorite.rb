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
end
