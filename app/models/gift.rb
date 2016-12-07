class Gift < ApplicationRecord
  belongs_to :buyer, class_name: "User"
  belongs_to :requester, class_name: "User"
  belongs_to :list

  def claimed
    return true if self.buyer_id
  end
end
