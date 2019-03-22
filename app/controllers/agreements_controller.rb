class AgreementsController < ApplicationController
  before_action :set_agreement, only: [:show, :update]
  before_action :authenticate, only: [:create, :update]

  def show
  end

  def create

    # Check if its single user or colaborative
    solo = true
    Discussion.find(add_agreement_params[:discussion_id]).avatars.each do |avatar|
      if avatar.user.id != current_user.id
        solo = false
      end
    end

    @agreement = Agreement.new(
      content: add_agreement_params[:content],
      is_accepted: solo,
      is_agree: add_agreement_params[:is_agree],
      avatar_id: add_agreement_params[:avatar_id].to_i,
      discussion_id: add_agreement_params[:discussion_id].to_i
    ) if Avatar.find(add_agreement_params[:avatar_id]).user.id == current_user.id # Verify if avatar is assigned to the user

    if @agreement && @agreement.save
      # Emit that new agreement has been proposed
      content = {
        id: @agreement.id,
        content: @agreement.content,
        isAccepted: @agreement.is_accepted,
        isAgree: @agreement.is_agree,
        proposedByAvatarId: @agreement.avatar.id,
        proposedByAvatarName: @agreement.avatar.name
      }
      ActionCable.server.broadcast 'discussion_room_#' + @agreement.discussion.id.to_s,
        type: 'agreement-propose',
        content: content.to_json
      # Render the new agreement
      render :show, status: :created, resource: @agreement
    else
      render json: { error: 'Invalid data'}, status: :unprocessable_entity
    end

  end

  def update

    #Check if its rejected and then delete it
    if respond_agreement_params[:is_accepted] == "false" && @agreement.avatar.id != respond_agreement_params[:avatar_id].to_i
      if @agreement && @agreement.destroy
        # Emit that agreement has been rejected
        ActionCable.server.broadcast 'discussion_room_#' + @agreement.discussion.id.to_s,
          type: 'agreement-reject',
          content: params[:id]
        # Render success message
        render json: { message: 'Agreement rejected and deleted'}, status: :ok
      else
        render json: { message: 'Invalid data'}, status: :unprocessable_entity
      end
      return
    end

    if @agreement.avatar.id != respond_agreement_params[:avatar_id].to_i && @agreement.update!(is_accepted: true)
      # Emit that agreement has been accepted
      ActionCable.server.broadcast 'discussion_room_#' + @agreement.discussion.id.to_s,
        type: 'agreement-accept',
        content: params[:id]
      # Render success message
      render :show, status: :ok, resource: @agreement
    else
      render json: { message: 'Invalid data'}, status: :unprocessable_entity
    end

  end

  private

  def set_agreement
    @agreement = Agreement.find(params[:id])
  end

  def add_agreement_params
    params.permit(:discussion_id, :avatar_id, :content, :is_agree)
  end

  def respond_agreement_params
    params.permit(:avatar_id, :is_accepted)
  end

end
