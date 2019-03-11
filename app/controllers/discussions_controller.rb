class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show, :invite]
  before_action :authenticate, only: [:invite, :verify_invitation]

  def show
  end

  def invite
    participant = Participant.new(discussion: @discussion, verified: false)
    Participant.generateUniqueToken(participant)
    if participant.save
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

  def verify_invitation
    if !Participant.where(token: verfy_invitation_params[:token]).exists?
      render :json => {message: "Couldn't find token invitation"}, status: :not_found
    end

    participant = Participant.find_by(token: verfy_invitation_params[:token])

    participant.update(user: current_user, verified: true)

    if participant.save
      render :json => {message: "Invitation verified"}, status: :ok
    else
      render :json => {message: "Couldn't verify the invitation"}, status: :unprocessable_entity
    end

  end

  private

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def invite_params
    params.permit(:email)
  end

  def verfy_invitation_params
    params.permit(:token)
  end

end
