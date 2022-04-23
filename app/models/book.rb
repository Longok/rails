class Book < ApplicationRecord
    has_many :bookoders
    has_many :reviews
    belongs_to :supplier
    belongs_to :author

end