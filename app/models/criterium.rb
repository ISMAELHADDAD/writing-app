class Criterium < ApplicationRecord
  belongs_to :discussion

  validates_presence_of :text
end
