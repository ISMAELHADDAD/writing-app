class AvatarsController < ApplicationController
  before_action :set_avatar, only: [:assign]
  before_action :authenticate, only: [:assign]

  def assign
    #If user doesn't exists
    if !User.where(id: assign_params[:user_id]).exists?
      render :json => {message: "User doesn't exists"}, status: :not_found
      return
    end

    #If user isn't participating in the discussion or current_user is not involved with the discussion
    if !Participant.where(discussion_id: assign_params[:discussion_id], user_id: assign_params[:user_id]).exists? ||
      !Participant.where(discussion_id: assign_params[:discussion_id], user_id: current_user.id).exists?
      render :json => {message: "User isn't participating in the discussion"}, status: :forbidden
      return
    end

    if @avatar.update(user_id: assign_params[:user_id])
      render :json => {message: "Avatar with id="+@avatar.id.to_s+
        " is assigned to user with id="+assign_params[:user_id].to_s }, status: :ok
    else
      render :json => {message: "Couldn't assign avatar"}, status: :unprocessable_entity
    end
  end

  private

  def set_avatar
    if params[:avatar_id]
      @avatar ||= Avatar.find(params[:avatar_id])
    else
      @avatar = Avatar.find(params[:id])
    end
  end

  def assign_params
    params.permit(:discussion_id, :user_id)
  end
end
