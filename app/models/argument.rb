class Argument < ApplicationRecord

  # model associations
  belongs_to :avatar
  belongs_to :discussion

  # validations
  validates_presence_of :num, :content, :publish_time
  
end
