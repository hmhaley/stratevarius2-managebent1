class SessionsController < ApplicationController

skip_before_filter :authorize

  def new
  end

  def create
        executive = Executive.where(username: params[:username]).first
        # first make sure we actually find a user
        # then see if user authenticates
        if executive && executive.authenticate(params[:password])

        # sets the cookie to the browser
            session[:executive_id] = executive.id
            redirect_to root_path, notice: "Logged in!"
        else
            flash.now.alert = "Username or password is invalid"
            # redirect_to new_session_path
            render "new"
        end
    end

    def destroy
        # Kill our cookies!
        reset_session
        redirect_to root_path, notice: "Logged out!"
    end

    
end