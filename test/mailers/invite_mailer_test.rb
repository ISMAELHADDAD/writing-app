require "test_helper"

class InviteMailerTest < ActionMailer::TestCase
  def test_invite_participant
    mail = InviteMailer.invite_participant("to@example.com", "TestUser", 1, "testtoken")
    assert_equal "Invitation to participate in a discussion", mail.subject
    assert_equal ["to@example.com"], mail.to
    assert_match "/authorize?discussion_id=1&token=testtoken", mail.body.encoded
  end

end
