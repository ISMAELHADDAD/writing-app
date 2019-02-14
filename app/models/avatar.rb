class Avatar < ApplicationRecord
  belongs_to :discussion
  belongs_to :user
  has_many :arguments
  has_many :agreements
end
