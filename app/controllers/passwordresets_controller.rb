class PasswordresetsController < ApplicationController
	def new
	end

	def create
       @user = User.find_by(user_params)
       

       if @user
          render 'show'   
       else
          render 'new'
       end
	end

	def show

        
             render 'new'
        
    end

	private

    def user_params
      params.require(:passwordresets).permit(:email )
    end
end
