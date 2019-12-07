class Review < ApplicationRecord
  validates_presence_of :title, :rating, :content
  # validates_numericality_of rating between 1 and 5
  belongs_to :shelter
end
