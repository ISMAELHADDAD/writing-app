class AgreementsController < ApplicationController
  before_action :set_agreement, only: [:show]

  def show
  end

  def create
    #TODO verify authorization

    @agreement = Agreement.new(
      content: add_agreement_params[:content],
      isAccepted: false,
      isAgree: add_agreement_params[:isAgree],
      avatar_id: add_agreement_params[:avatar_id].to_i,
      discussion_id: add_agreement_params[:discussion_id].to_i
    ) if Avatar.find(add_agreement_params[:avatar_id]).user.id == add_agreement_params[:user_id].to_i # Verify if avatar is assigned to the user

    if @agreement && @agreement.save
      render :show, status: :created, resource: @agreement
    else
      render json: { error: 'Invalid data'}, status: :unprocessable_entity
    end

  end

  private

  def set_agreement
    @agreement = Agreement.find(params[:id])
  end

  def add_agreement_params
    params.permit(:discussion_id, :user_id, :avatar_id, :content, :isAgree)
  end

end
