class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show]

  def show
  end

  private

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

end
