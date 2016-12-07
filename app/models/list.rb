class List < ApplicationRecord
  has_many :gifts
  # has_many :users, through: :gifts
end
