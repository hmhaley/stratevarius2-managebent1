class SessionsController < ApplicationController

skip_before_filter :authorize

  def new
  end

  def create
        executive = Executive.where(username: params[:username]).first
        if executive && executive.authenticate(params[:password]) 
            session[:executive_id] = executive.id
            redirect_to root_path, notice: "Logged in!"
        else
            flash.now.alert = "Username or password is invalid"
            render "new"
        end
    end

    def destroy
        # Kill our cookies!
        reset_session
        redirect_to root_path, notice: "Logged out!"
    end

    
end