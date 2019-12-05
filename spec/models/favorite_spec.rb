require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "validations" do
    it {should validate_presence_of :pet_id}
  end

  describe "relationships" do
    it {should belong_to :pet}
  end
end
