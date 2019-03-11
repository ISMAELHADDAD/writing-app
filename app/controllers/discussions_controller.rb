class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show, :invite]
  before_action :authenticate, only: [:invite]

  def show
  end

  def invite
    participant = Participant.new(discussion: @discussion, verified: false)
    if participant.save
      Participant.generateUniqueToken(participant)
      InviteMailer.invite_participant(
        invite_params[:email],  # Email to
        current_user.name, # Username who makes the invite
        @discussion.id, # Discussion involved
        participant.token # Token for identifying the invitation
      ).deliver_now
    else
      render :json => {message: "Couldn't generate an invitation"}, status: :unprocessable_entity
    end
  end

  private

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def invite_params
    params.permit(:email)
  end

end
