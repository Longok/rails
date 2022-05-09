class Book < ApplicationRecord
    has_many :book_orders
    has_many :reviews
    belongs_to :supplier
    belongs_to :author
end
