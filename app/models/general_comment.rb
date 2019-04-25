class GeneralComment < ApplicationRecord
  belongs_to :user
  belongs_to :discussion

  validates_presence_of :text
end
