class Cart < ApplicationRecord
    has_many :bills, dependent: :destroy
    has_many :products, through: :bills


    def total_bill
        sum = 0
        self.bills.each do |bill|
          sum += bill.total_pirce
        end
        return sum
    end

    def total_quantity
        quantity = 0
        self.bills.each do |bill|
          quantity += bill.quantity
        end
        return quantity
    end

    def add_product(product)
      current_item = bills.find_by product_id: (product)
      if current_item 
          current_item.quantity += 1
      else
          current_item = bills.build(:product_id => product.id)
      end
      current_item
    end
end
