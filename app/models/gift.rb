class Gift < ApplicationRecord
  has_one :buyer
  belongs_to :requester

end
