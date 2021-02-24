class FriendsController < ApplicationController
  def index
    @friends = current_user.friends 
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend], current_user)

      if @friends
        respond_to do |format|
          format.js { render partial: 'friends/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'Please enter a valid friend to search'
          format.js { render partial: 'friends/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a friend to search'
        format.js { render partial: 'friends/result' }
      end
    end
  end

  def create
    friend = User.find(params[:friend])
    if friend.present?
      friendship = Friendship.new(user: current_user, friend: friend)
      friendship.save
    end

    flash[:notice] = "#{friend.full_name} was successfully added as friend."
    redirect_to friends_path
  end

  def destroy
    friend = User.find(params[:id])
    friendship = current_user.friendships.find_by(friend: friend)
    friendship.destroy

    flash[:notice] = "Unfriended #{friend.full_name}" 
    redirect_to friends_path
  end
end
