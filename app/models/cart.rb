class Cart < ApplicationRecord
    has_many :cart_items
    has_many :payments
    has_many :products, through: :bills

    def total_cart_item
      cart_items.pluck(:total_pirce).sum
    end

    def total_quantity
      cart_items.pluck(:quantity).sum
    end

    def add_product(product)
      current_item = cart_items.find_or_initialize_by(product_id: product)
      current_item.quantity += 1
    end
end
