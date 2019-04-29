class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :update]
  before_action :check_discussion_existence
  before_action :check_avatar_existence
  before_action :authenticate, only: [:update]

  def index
    @ratings = Rating.where(avatar_id: params[:avatar_id].to_i).order(:created_at) if params[:avatar_id]
  end

  def show
  end

  def update

    if @rating.avatar.discussion.user.id != current_user.id
      message = 'User with id=' + current_user.id.to_s + ' is not an owner of the discussion with id=' + @rating.avatar.discussion.id.to_s
      render json: { message: message}, status: :forbidden
      return
    end

    @rating.update(rating: set_rating_params[:rating].to_i)

    if @rating.save
      render :show, status: :ok, resource: @rating
    else
      render json: { message: 'Invalid data'}, status: :unprocessable_entity
    end

  end

  private

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def check_discussion_existence
    Discussion.find(params[:discussion_id])
  end

  def check_avatar_existence
    a = Avatar.find(params[:avatar_id])
    #Check if avatar participates in the discussion
    if a.discussion.id != params[:discussion_id].to_i
      message = 'Avatar with id=' + params[:avatar_id] + ' does not participate in the discussion with id=' + params[:discussion_id]
      render json: { message: message}, status: :forbidden
      return
    end
  end

  def set_rating_params
    params.permit(:rating)
  end

end
