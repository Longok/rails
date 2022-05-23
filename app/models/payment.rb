class Payment < ApplicationRecord
    belongs_to :bill
    belongs_to :user
end
