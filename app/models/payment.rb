class Payment < ApplicationRecord
    belongs_to :bill
    belongs_to :user
    
    PAYMENT_TYPE = ["Cash on delivery(COD)", "Chuyển khoản"]
    validates :address, :payment_type, presence: true, length: {minimum: 6}
    validates :phone_number, presence: true, length: {minimum: 9, maximum: 10}
    validates :payment_type, :inclusion => PAYMENT_TYPE 
end
