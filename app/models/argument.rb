class Argument < ApplicationRecord

  # model associations
  belongs_to :avatar
  belongs_to :discussion, counter_cache: true

  # validations
  validates_presence_of :num, :content, :publish_time

end
