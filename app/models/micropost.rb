class Micropost < ApplicationRecord
  belongs_to :user
  # has_one_attached :image 
  has_many_attached :images 

  
  # default_scope -> { order(created_at: :desc) }
  scope :recent_posts, -> {order created_at: :desc}

  validates :user_id, presence: true
  validates :content, presence: true
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png], 
                            message: "must be a valid image format" },
                            size: { less_than: 5.megabytes,
                            message: "should be less than 5MB" }

  # Returns a resized image for display.
  def display_images
    images.map { |image| image.variant(resize_to_limit: [500, 500]) }
  end

end
