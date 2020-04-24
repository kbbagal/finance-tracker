class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)

    if current_user.save
      flash[:notice] = "Started following #{friend.display_name}!"
    else
      flash[:alert] = 'Something went wrong!'
    end

    redirect_to :friends
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friend = User.find(params[:id])
    friendship.destroy if friendship

    flash[:notice] = "Stopped following #{friend.display_name}!"

    redirect_to :friends
  end
end
