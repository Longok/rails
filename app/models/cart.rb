class Cart < ApplicationRecord
    has_many :cart_items, dependent: :delete_all
    has_many :payments
    has_many :products, through: :bills

    def total_cart_item
        sum = 0
        self.cart_items.each do |cart_item|
          sum += cart_item.total_pirce
        end
        return sum
    end

    def total_quantity
        quantity = 0
        self.cart_items.each do |cart_item|
          quantity += cart_item.quantity
        end
        return quantity
    end

    def add_product(product)
      current_item = cart_items.find_by product_id: (product)
      if current_item 
          current_item.quantity += 1
      else
          current_item = cart_items.build(:product_id => product.id)
      end
      current_item
    end
end
