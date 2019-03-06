class AgreementsController < ApplicationController
  before_action :set_agreement, only: [:show, :update]
  before_action :authenticate, only: [:create, :update]

  def show
  end

  def create
    #TODO verify authorization
    if current_user.id != add_agreement_params[:user_id]
      render json: { message: 'Unauthorized' }, status: :unauthorized
      return
    end

    #Check user exists
    if !User.exists?(add_agreement_params[:user_id])
      render json: { message: 'Couldn\'t find User with id='+add_agreement_params[:user_id] }, status: :not_found
      return
    end

    # Check if its single user or colaborative
    solo = true
    Discussion.find(add_agreement_params[:discussion_id]).avatars.each do |avatar|
      if avatar.user.id != add_agreement_params[:user_id].to_i
        solo = false
      end
    end

    @agreement = Agreement.new(
      content: add_agreement_params[:content],
      isAccepted: solo,
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

  def update
    #TODO verify authorization
    if current_user.id != respond_agreement_params[:user_id]
      render json: { message: 'Unauthorized' }, status: :unauthorized
      return
    end

    #Check user exists
    if !User.exists?(respond_agreement_params[:user_id])
      render json: { message: 'Couldn\'t find User with id='+respond_agreement_params[:user_id] }, status: :not_found
      return
    end

    #Check if its rejected and then delete it
    if respond_agreement_params[:isAccepted] == "false" && @agreement.avatar.id != respond_agreement_params[:avatar_id].to_i
      if @agreement && @agreement.destroy
        render json: { message: 'Agreement rejected and deleted'}, status: :ok
      else
        render json: { message: 'Invalid data'}, status: :unprocessable_entity
      end
      return
    end

    if @agreement.avatar.id != respond_agreement_params[:avatar_id].to_i && @agreement.update!(isAccepted: true)
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
    params.permit(:discussion_id, :user_id, :avatar_id, :content, :isAgree)
  end

  def respond_agreement_params
    params.permit(:user_id, :avatar_id, :isAccepted)
  end

end
