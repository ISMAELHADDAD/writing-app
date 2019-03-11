class InviteMailer < ApplicationMailer

  def invite_participant(email, from, discussion_id, token)
    @url = "https://ideashub-client.herokuapp.com/authorize?" +
    "discussion_id=" + discussion_id.to_s + "&" +
    "token=" + token

    @from = from

    mail to: email, subject: "Invitation to participate in a discussion"
  end

end
