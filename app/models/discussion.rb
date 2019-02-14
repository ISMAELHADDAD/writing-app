class Discussion < ApplicationRecord
  belongs_to :user
  has_many :agreements
  has_many :arguments
  has_many :avatars
end
