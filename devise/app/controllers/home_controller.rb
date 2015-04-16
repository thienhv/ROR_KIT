class HomeController < ApplicationController
	before_filter :authenticate_user!,  except: [:index]
	
	def index
	end

	def send_email_welcome
		UserMailer.welcome_email(current_user).deliver_now
		render plain: "Ok"
	end
end
