class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	skip_before_filter :authorize

private

	def current_user
    	@current_user ||= Executive.find(session[:executive_id]) if session[:executive_id] 
  	end

  	helper_method :current_user

	def authorize
		redirect_to signin_path, alert: "You are Not Authorized to view this page.  Please Sign-Up or Login." if current_user.nil?
	end

	# def add_partner_link(organization = nil)
	# 			html = ""
 #    	html << render(:partial => 'shared/add_partner_link', :locals => {:organization => organization})
	# 		html.html_safe
	# end
end
