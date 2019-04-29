class Avatar < ApplicationRecord

  # model associations
  belongs_to :discussion
  belongs_to :user
  has_many :arguments, dependent: :destroy
  has_many :agreements, dependent: :destroy
  has_many :ratings, dependent: :destroy

  # validations
  validates_presence_of :name
end
