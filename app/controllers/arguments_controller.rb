class ArgumentsController < ApplicationController
  before_action :set_discussion, only: [:show]

  def show
  end

  def create
    #TODO verify authorization

    #Check user exists
    if !User.exists?(add_argument_params[:user_id])
      render json: { message: 'Couldn\'t find User with id='+add_argument_params[:user_id] }, status: :not_found
      return
    end

    @argument = Argument.new(
      num: (Discussion.find(add_argument_params[:discussion_id].to_i).arguments.size + 1),
      content: add_argument_params[:content],
      avatar_id: add_argument_params[:avatar_id].to_i,
      discussion_id: add_argument_params[:discussion_id].to_i,
      publish_time: DateTime.now
    ) if Avatar.find(add_argument_params[:avatar_id]).user.id == add_argument_params[:user_id].to_i # Verify if avatar is assigned to the user

    if @argument && @argument.save
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
