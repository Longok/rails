class Product < ApplicationRecord
    has_many :bills

    has_one_attached :image 

    validates :name, uniqueness: true, presence: true, length: {minimum: 4}
    validates :price, presence: true

    validates :image, content_type: { in: %w[image/jpeg image/gif image/png], 
                            message: "must be a valid image format" },
                            size: { less_than: 5.megabytes,
                            message: "should be less than 5MB" }

    # Returns a resized image for display.
    def display_image
        image.variant(resize_to_limit: [180, 180])
    end


end
