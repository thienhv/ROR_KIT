module V1
	class UserAPI < Grape::API
		resource :users do
			#
			desc "user register account"
			params do
				requires :email, type: String, desc: "Email of user"
				requires :password, type: String, desc: "Password" 
			end
			post do
				user = User.create!({
					email: params[:email],
					password: params[:password]
					})

				{result: true,
					user_id: user.id,
					token: user.api_key.access_token}
			end
		end
	end
end