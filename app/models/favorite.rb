class Favorite < ApplicationRecord
  validates_presence_of :pet_id
  belongs_to :pet


  def self.all_favorited
    count
  end

end
