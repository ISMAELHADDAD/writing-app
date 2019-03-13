class User < ApplicationRecord

  # model associations
  has_many :discussions, dependent: :destroy
  has_many :avatars, dependent: :destroy

  has_many :participants

  # validations
  validates_presence_of :name
  validates_uniqueness_of :name, :session_token

  def self.generateUniqueSessionToken(user)
    st = SecureRandom.urlsafe_base64(nil, false)
    while User.where(session_token: st).exists?
      st = SecureRandom.urlsafe_base64(nil, false)
    end
    user.session_token = st
    user.session_token_expires_at = DateTime.current.in(3600 + 60*60)
  end

end
