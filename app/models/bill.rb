class Bill < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  has_many :payments

  def total_pirce
    self.quantity * self.product.price
  end


end
