class AddImageToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :image, :string, default: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images_shelters/img_shelter_1_german_shepherds.jpg'
  end
end
