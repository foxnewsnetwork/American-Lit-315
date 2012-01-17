module UsersHelper
	# TODO: write functions to handle signing in

	def active_user	
		# Assumes our first user is anonymous
		@user ||= current_user
		@user ||= User.first
	end
	
	# Function uses the stuff in the info hash to find and login the user or create one if one doesn't exist
	# Keys that should be i nthe parameter hash
	# :email, :password, :username
	def api_find_or_create_user( info )
		# TODO: write me!
	end
end
