class Rating < ApplicationRecord
  belongs_to :avatar
  belongs_to :criterium

  validates_inclusion_of :rating, :in => 0..5
end
