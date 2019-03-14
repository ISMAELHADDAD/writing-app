class Discussion < ApplicationRecord

  # model associations
  belongs_to :user
  has_many :agreements, dependent: :destroy
  has_many :arguments, dependent: :destroy
  has_many :avatars, dependent: :destroy

  has_many :participants

  # validations
  validates_presence_of :topic_title, :user_id
end
