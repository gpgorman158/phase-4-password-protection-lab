class SessionsController < ApplicationController

    def create
        #find user based on entered username on frontend. use strong params inputted
        user = User.find_by(username: params[:username])
        #check if password matches username in database. Takes inputted password and salts it to check if it is a match to stored password digest
        if user&.authenticate(params[:password]) 
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { error:  {login: "invalid username or password"}}, status: :unauthorized
        end

    end

    def destroy
        session.delete :user_id
        head :no_content
    end

    private
    def user_params
        params.permit(:username, :password)
    end
end
