class RootV1 < Grape::API
	version 'v1'
	format :json
	prefix :api
	
	#
	helpers do
		def authentication?
			error!('Unauthentication, token invalid or expired', 401) unless current_user
		end

		def current_user
			token = ApiKey.where(access_token: params[:token]).first
			if token && !token.expired?
				@current_user = User.find(token.user_id)
			else
				false
			end
		end
	end
	#

	mount V1::UserAPI
	mount V1::AuthAPI
end