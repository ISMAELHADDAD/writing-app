# Preview all emails at http://localhost:3000/rails/mailers/invite_mailer
class InviteMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invite_mailer/invite_participant
  def invite_participant
    InviteMailer.invite_participant("fulano@test.com","Ismael Haddad",1,"wo77shsBS65SsuVahuBYGS")
  end

end
