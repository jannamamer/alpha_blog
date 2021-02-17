class FriendsController < ApplicationController
  def index
    @friends = current_user.friends 
  end

  def destroy
    friend = User.find(params[:id])
    friendship = current_user.friendships.find_by(friend: friend)
    friendship.destroy

    flash[:notice] = "Unfriended #{friend.full_name}" 
    redirect_to friends_path
  end
end
