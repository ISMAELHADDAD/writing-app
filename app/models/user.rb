class User < ApplicationRecord

  # model associations
  has_many :discussions, dependent: :destroy
  has_many :avatars, dependent: :destroy

  # validations
  validates_presence_of :name
end
