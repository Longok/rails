class Customer < ApplicationRecord
    has_many :oders
    has_many :reviews
end