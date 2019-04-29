class Discussion < ApplicationRecord

  # model associations
  belongs_to :user
  has_many :agreements, dependent: :destroy
  has_many :arguments, dependent: :destroy
  has_many :avatars, dependent: :destroy
  has_many :general_comments, dependent: :destroy
  has_many :criteria, dependent: :destroy

  has_many :participants, dependent: :destroy

  # validations
  validates_presence_of :user_id
end
