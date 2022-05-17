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
end
