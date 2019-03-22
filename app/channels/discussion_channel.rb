class DiscussionChannel < ApplicationCable::Channel

  def subscribed
    stream_from ( 'discussion_room_#'+params[:room].to_s )
  end

end
