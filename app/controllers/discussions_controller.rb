class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show, :destroy, :invite, :fork]
  before_action :authenticate, only: [:create, :destroy, :invite, :verify_invitation, :fork]

  def index
    if params[:user_id]
      if request.headers["Authorization"] && sessionToken_valid?
        @discussions = Discussion.where(user_id: params[:user_id]).order(created_at: :desc).page params[:page]
      else
        @discussions = Discussion.where(user_id: params[:user_id], private: false).order(created_at: :desc).page params[:page]
      end
    else
      @discussions = Discussion.where(private: false).order(created_at: :desc).page params[:page]
    end
  end

  def show
  end

  def create

    @discussion = Discussion.create(
      topic_title: create_discussion_paramas[:topic_title],
      topic_description: create_discussion_paramas[:topic_description],
      private: create_discussion_paramas[:private],
      user: current_user
    )
    avatar_one = Avatar.create(
      name: create_discussion_paramas[:name_avatar_one],
      opinion: create_discussion_paramas[:opinion_avatar_one],
      discussion: @discussion,
      user: current_user
    )
    avatar_two = Avatar.create(
      name: create_discussion_paramas[:name_avatar_two],
      opinion: create_discussion_paramas[:opinion_avatar_two],
      discussion: @discussion,
      user: current_user
    )
    participant = Participant.create(
      discussion: @discussion,
      user: current_user,
      token: nil,
      verified: true
    )

    if @discussion.save && avatar_one.save && avatar_two.save && participant.save
      render :show, status: :created, resource: @discussion
    else
      render json: { message: 'Invalid data'}, status: :unprocessable_entity
    end

  end

  def destroy
    if @discussion.user.id != current_user.id
      render json: { message: 'Only owner of the discussion can delete it'}, status: :unauthorized
      return
    end

    if @discussion.destroy
      render json: { message: 'Discussion deleted'}, status: :ok
    else
      render json: @discussion.errors, status: :unprocessable_entity
    end
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
      # Emit that participant has been verified
      ActionCable.server.broadcast 'discussion_room_#' + participant.discussion.id.to_s,
        type: 'participant-verified',
        content: participant.user.id
      # Render success message
      render :json => {message: "Invitation verified"}, status: :ok
    else
      render :json => {message: "Couldn't verify the invitation"}, status: :unprocessable_entity
    end

  end

  def fork
    new_discussion = @discussion.dup
    new_discussion.update(user_id: current_user.id, forked_from: @discussion.id)

    new_avatar_one = @discussion.avatars.first.dup
    new_avatar_one.update(user_id: current_user.id, discussion_id: new_discussion.id)
    new_avatar_two = @discussion.avatars.second.dup
    new_avatar_two.update(user_id: current_user.id, discussion_id: new_discussion.id)

    @discussion.arguments.each do |argument|
      new_argument = argument.dup
      if argument.avatar.id == @discussion.avatars.first.id
        new_argument.update(avatar_id: new_avatar_one.id, discussion_id: new_discussion.id)
      else
        new_argument.update(avatar_id: new_avatar_two.id, discussion_id: new_discussion.id)
      end
    end

    @discussion.agreements.each do |agreement|
      new_agreement = agreement.dup
      if agreement.avatar.id == @discussion.avatars.first.id
        new_agreement.update(avatar_id: new_avatar_one.id, discussion_id: new_discussion.id)
      else
        new_agreement.update(avatar_id: new_avatar_two.id, discussion_id: new_discussion.id)
      end
    end

    participant = Participant.create(discussion: new_discussion, user: current_user, token: nil, verified: true)

    if new_discussion.save && new_avatar_one.save && new_avatar_two.save && participant.save
      render :json => {message: "Forked with success", id: new_discussion.id}, status: :ok
    else
      render :json => {message: "Invalid fork"}, status: :unprocessable_entity
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

  def create_discussion_paramas
    params.permit(:topic_title, :topic_description, :private, :name_avatar_one, :opinion_avatar_one, :name_avatar_two, :opinion_avatar_two)
  end

  def invite_params
    params.permit(:email)
  end

  def verfy_invitation_params
    params.permit(:token)
  end

end
