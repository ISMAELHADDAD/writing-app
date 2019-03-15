class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show, :invite]
  before_action :authenticate, only: [:invite, :verify_invitation]

  def index
    @discussions = Discussion.all
  end

  def show
  end

  def invite

    # Only owner of the discussion can make invitation
    if @discussion.user.id != current_user.id
      render :json => {message: "Only owner of the discussion can make invitation"},
        status: :unauthorized
      return
    end

    participant = Participant.new(discussion: @discussion, verified: false)
    Participant.generateUniqueToken(participant)
    if participant.save
      InviteMailer.invite_participant(
        invite_params[:email],  # Email to
        current_user.name, # Username who makes the invite
        @discussion.id, # Discussion involved
        participant.token # Token for identifying the invitation
      ).deliver_now if Rails.env.production?
      render :json => {message: "Invitation send"}, status: :ok
    else
      render :json => {message: "Couldn't generate an invitation"}, status: :unprocessable_entity
    end
  end

  def verify_invitation
    if !Participant.where(token: verfy_invitation_params[:token]).exists?
      render :json => {message: "Couldn't find token invitation"}, status: :not_found
      return
    end

    participant = Participant.find_by(token: verfy_invitation_params[:token])

    if participant.verified
      render :json => {message: "Token already verified"}, status: :forbidden
      return
    end

    participant.update(user_id: current_user.id, verified: true)

    if participant.save
      render :json => {message: "Invitation verified"}, status: :ok
    else
      render :json => {message: "Couldn't verify the invitation"}, status: :unprocessable_entity
    end

  end

  private

  def set_discussion
    if params[:discussion_id]
      @discussion ||= Discussion.find(params[:discussion_id])
    else
      @discussion = Discussion.find(params[:id])
    end
  end

  def invite_params
    params.permit(:email)
  end

  def verfy_invitation_params
    params.permit(:token)
  end

end
