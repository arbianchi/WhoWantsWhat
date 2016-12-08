class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :gifts, foreign_key: "requester_id"
  has_many :gifts, foreign_key: "buyer_id"
  has_and_belongs_to_many :lists
  # belongs_to :list, through: :gifts
end
