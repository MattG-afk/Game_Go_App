class SessionsController < ApplicationController
    skip_before_action :redirect_to_login
    helper_method :auth

    def new
    end


    def create
        @user = User.find_by(:email => params[:email])
        if @user && @user.authenticate(params[:password])
            login(@user)
            flash[:success] = "Successful login"
            redirect_to "/"
        else
          redirect_to "/login", :notice => "Can't find your login."
        end
    end
    
    def destroy
        reset_session
        redirect_to "/"
    end
    
    def omniauth
        @user = User.from_omniauth(auth)
        @user.save
        session[:current_user_id] = user.id
        redirect_to games_path
    end


    private

    def auth
        request.env['omniauth.auth']
    end

end

