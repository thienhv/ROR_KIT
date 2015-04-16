Rails.application.routes.draw do
	devise_for :users, 
	:path => 'users', 
	:path_names => { 
		:sign_in => "login", :sign_out => "logout", :sign_up => "register" 
	},
	:controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	root to: "home#index"
	get "/send_email_welcome", to: "home#send_email_welcome"

	# API
	mount Twitter::API => '/'
end
