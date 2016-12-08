class Gift < ApplicationRecord
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to :requester, class_name: "User"
  belongs_to :list

end
