class Discussion < ApplicationRecord

  # model associations
  belongs_to :user
  has_many :agreements, dependent: :destroy
  has_many :arguments, dependent: :destroy
  has_many :avatars, dependent: :destroy

  # validations
  validates_presence_of :topicTitle, :user_id
end
