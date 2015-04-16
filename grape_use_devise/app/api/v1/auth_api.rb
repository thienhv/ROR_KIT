module V1
	class AuthAPI < Grape::API
		resource :auth do
			desc "Login"
			params do
				requires :email, type: String, desc: "Email"
				requires :password, type: String, desc: "Password"
			end
			post do
				user = User.find_by_email(params[:email])
				if user && user.valid_password?(params[:password])
					##Update new token
					token = ApiKey.find_by_user_id(user.id)
					new_token = token.generate_access_token
					token.save()
					{result: true,
						user_id: user.id,
						token: new_token}
				else
						{result: false,
							title: 'login faile'}
				end
			end
			###
			desc "Logout"
			params do
				requires :token, type: String, desc: "Access token"
				requires :email, type: String, desc: "Email user login"
			end
			delete do
				authentication?
				user = User.find_by_email(params[:email])
				token = user.api_key
				token.access_token = ""
				token.save()

				{result: true,
					title: 'Logout success fully'}
			end
			###
		end
	end
end