class FriendshipsController < ApplicationController



  def create
    @friendship_requested = current_user.friendships.build(:friend_id => params[:friend_id],:status => "requested")
    
    user = User.find_by(id: params[:friend_id])
    @friendship_pending = user.friendships.build(:friend_id => current_user.id,:status => "pending")
    
    if @friendship_requested.save && @friendship_pending.save
    	flash[:notice] = "Friend Added"
    	redirect_to user_path(current_user)
    else
     flash[:notice] = "Unable to add friend"
    redirect_to user_path(current_user)
   end
end


def update
    
     update_user_status = Friendship.where(:user_id => current_user.id , :friend_id => params[:id])
     update_friend_status = Friendship.where(:user_id => params[:id] , :friend_id => current_user.id)
     
     if update_user_status.update(:status => "accepted") && update_friend_status.update(:status => "accepted")
            flash[:notice] = "Friend Request Accepted"
            redirect_to user_path(current_user)
     else
           flash[:notice] = "Unable To Accept Friend Request"
           redirect_to user_path(current_user)

     end   
 
end



def destroy
    friendship_to_delete= Friendship.where(:user_id => current_user.id, :friend_id => params[:id]).first
    reverse_friendship_to_delete= Friendship.where(:user_id => params[:id], :friend_id => current_user).first

    if friendship_to_delete.destroy &&  reverse_friendship_to_delete.destroy
        flash[:notice] = "Friend Deleted"
        redirect_to user_path(current_user)
    else
        flash[:notice] = "Unable to delete Friend"
        redirect_to user_path(current_user)
    end
end
end
