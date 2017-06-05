class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
    @all_users = User.where.not(id: @user.id ) - @user.friends

    @accepted_friends = @user.accepted_friends
    @pending_friends = @user.pending_friends 
    @requested_friends = @user.requested_friends  

  end


  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
    	  flash[:success] = "Welcome to the Sample App!"
          redirect_to @user
    else
      render 'new'
    end
  end

  
  def edit
    @user = User.find(params[:id])
  end
  

  def update
  @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
    else
      render 'edit'
    end
  end


  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :username, :email, :password,
                                   :image )
    end
  end
