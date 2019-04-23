class ArgumentsController < ApplicationController
  before_action :set_argument, only: [:show]
  before_action :authenticate, only: [:create]

  def index
    @arguments = Argument.where(discussion_id: params[:discussion_id]).order(:created_at) if params[:discussion_id]
  end

  def show
  end

  def create

    @argument = Argument.new(
      num: (Discussion.find(add_argument_params[:discussion_id].to_i).arguments.size + 1),
      content: add_argument_params[:content],
      avatar_id: add_argument_params[:avatar_id].to_i,
      discussion_id: add_argument_params[:discussion_id].to_i,
      publish_time: DateTime.now
    ) if Avatar.find(add_argument_params[:avatar_id]).user.id == current_user.id # Verify if avatar is assigned to the user

    if @argument && @argument.save
      # Emit that new argument has been published
      content = {
        id: @argument.id,
        num: @argument.num,
        content: @argument.content,
        publishTime: @argument.publish_time,
        fromAvatar: {
          id: @argument.avatar.id,
          name: @argument.avatar.name
        }
      }
      ActionCable.server.broadcast 'discussion_room_#' + @argument.discussion.id.to_s,
        type: 'argument',
        content: content.to_json
      # Render the new argument
      render :show, status: :created, resource: @argument
    else
      render json: { message: 'Invalid data'}, status: :unprocessable_entity
    end

  end

  private

  def set_argument
    @argument = Argument.find(params[:id])
  end

  def add_argument_params
    params.permit(:discussion_id, :user_id, :avatar_id, :content)
  end

end
