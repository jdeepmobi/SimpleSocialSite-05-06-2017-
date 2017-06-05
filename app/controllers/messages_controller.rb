class MessagesController < ApplicationController
  def show
  end

  def new

     
     @rec = (Conversation.where('(user_id= ? AND exchange_id= ?) OR (user_id= ? AND exchange_id= ?)',params[:user_id],params[:friendship_id],params[:friendship_id],params[:user_id])).first
     if @rec
     @messages=@rec.messages

 else
 	@messages=[]
 end
        
    @user_rec = User.find(params[:user_id])
    @friend_rec = User.find(params[:friendship_id])







  end

  def create
  	
    @converse = (Conversation.where('(user_id= ? AND exchange_id= ?) OR (user_id= ? AND exchange_id= ?)',params[:user_id],params[:friendship_id],params[:friendship_id],params[:user_id])).first
      
    if @converse
    	  
              conv = @converse.messages.build(:user_id=> current_user.id, msg: params[:message][:msg])
              if conv.save
              	 flash[:notice] = "Message successfully sent"
              	 redirect_to new_user_friendship_message_path
              end
    else
              conv = current_user.conversations.build(:exchange_id => params[:friendship_id])
                 if conv.save
                   	msg_build = conv.messages.build(:user_id=> current_user.id, msg: params[:message][:msg])
                  
                      if msg_build.save
                      	    flash[:notice] = "Message successfully sent"
				        	redirect_to new_user_friendship_message_path
				      end
                  end
    end

  end

  private

  def create_message()
      #messages.build(:user_id=> current_user.id, msg: params[:message][:msg])
  end
end
