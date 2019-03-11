class Participant < ApplicationRecord

  # model associations
  belongs_to :user
  belongs_to :discussion

  def self.generateUniqueToken(participant)
    t = SecureRandom.urlsafe_base64(nil, false)
    while User.where(session_token: t).exists?
      t = SecureRandom.urlsafe_base64(nil, false)
    end
    participant.token = st
  end

end
