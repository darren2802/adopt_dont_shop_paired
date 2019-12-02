require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :image}
    it {should validate_presence_of :age_approx}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :shelter_id}
    it {should validate_presence_of :breed}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end
end
