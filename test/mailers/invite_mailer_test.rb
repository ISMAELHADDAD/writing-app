require "test_helper"

class InviteMailerTest < ActionMailer::TestCase
  def test_invite_participant
    mail = InviteMailer.invite_participant
    assert_equal "Invite participant", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
