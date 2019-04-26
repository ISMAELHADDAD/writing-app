class CriteriaController < ApplicationController
  before_action :set_criterium, only: [:show]
  before_action :authenticate, only: [:create]

  def index
    @criteria = Criterium.where(discussion_id: params[:discussion_id]).order(:created_at) if params[:discussion_id]
  end

  def show
  end

  def create

    d = Discussion.find(add_criterium_params[:discussion_id])
    if d.user.id != current_user.id
      render :json => {message: "User with id="+d.user.id.to_s+" is not the owner of the discussion"}, status: :forbidden
      return
    end

    @criterium = Criterium.new(
      text: add_criterium_params[:text],
      discussion_id: add_criterium_params[:discussion_id].to_i
    ) if Discussion.find(add_criterium_params[:discussion_id])

    if @criterium && @criterium.save
      render :show, status: :created, resource: @criterium
    else
      render json: { error: 'Invalid data'}, status: :unprocessable_entity
    end

  end

  private

  def set_criterium
    @criterium = Criterium.find(params[:id])
  end

  def add_criterium_params
    params.permit(:discussion_id, :text)
  end

end
