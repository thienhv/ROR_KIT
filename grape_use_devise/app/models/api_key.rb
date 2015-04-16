class ApiKey < ActiveRecord::Base
		before_create :generate_access_token
		before_create :set_time_expired

		has_one :user

		def expired?
			DateTime.now >= self.expires_at
		end

		def generate_access_token
			self.access_token = Digest::MD5.hexdigest("#{Time.now.to_i.to_s}
				#{SecureRandom.hex} 
				#{self.user_id}")
		end

		private
		def set_time_expired
			self.expires_at = DateTime.now + 30
		end
end
