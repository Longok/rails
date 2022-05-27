class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_pirce
    self.quantity * self.product.price
  end
end
