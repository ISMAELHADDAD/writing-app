class Agreement < ApplicationRecord

  # model associations
  belongs_to :avatar
  belongs_to :discussion

  # validations
  validates_presence_of :content, :isAccepted, :isAgree

end
