class Customer < ApplicationRecord
    has_many :orders
    has_many :reviews
    has_many :booked, through: :orders, source: :books
    # has_many :reviewer, through: :reviews, source: :book
    has_many :books, through: :reviews
end

