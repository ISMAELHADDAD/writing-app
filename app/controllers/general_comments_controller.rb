class GeneralCommentsController < ApplicationController
  before_action :set_general_comment, only: [:show]
  before_action :authenticate, only: [:create]

  def index
    @general_comments = GeneralComment.where(discussion_id: params[:discussion_id]).order(:created_at) if params[:discussion_id]
  end

  def show
  end

  def create
    
    @general_comment = GeneralComment.new(
      text: add_general_comment_params[:text],
      user: current_user,
      discussion_id: add_general_comment_params[:discussion_id].to_i
    ) if Discussion.find(add_general_comment_params[:discussion_id])

    if @general_comment && @general_comment.save
      render :show, status: :created, resource: @general_comment
    else
      render json: { error: 'Invalid data'}, status: :unprocessable_entity
    end

  end

  private

  def set_general_comment
    @general_comment = GeneralComment.find(params[:id])
  end

  def add_general_comment_params
    params.permit(:discussion_id, :text)
  end

end
