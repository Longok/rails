class Cart < ApplicationRecord
    has_many :bills
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

    def add_product(product_id)
      current_item = bills.find_by(product_id: product_id)
      if current_item 
          current_item.quantity += 1
      else
          current_item = bills.build(product_id: product_id)
      end
      current_item
    end
end
