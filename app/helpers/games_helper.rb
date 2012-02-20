module GamesHelper
	# return the total earnings for a given game
	# or return 0 if total earnings is nil (no record)
	def totaldays(id)
		GameEarnings.select("sum(earnings) as earning").where("game_id='#{id}'").first.earning || 0
	end
end
