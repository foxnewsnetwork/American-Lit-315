xml.instruct!
xml.response do 
	xml.company do
		xml.id @company.id
		xml.name @company.name
	end
	xml.ad do
		xml.id @ad.id
		xml.name @ad.name
		xml.description @ad.description
		xml.created_at @ad.created_at
		xml.updated_at @ad.updated_at
		xml.limit @ad.limit
		xml.type @ad.type
		xml.cost_per_1k_views @ad.cost_per_impression
		xml.cost_per_1k_clicks @ad.cost_per_click
		xml.cost_per_1k_purchases @ad.cost_per_purchase
		xml.love_hatred @ad.love_hate
		xml.relief_fear @ad.relief_fear
		xml.excitement_boredom @ad.excite_bore
		xml.happy_sad @ad.happy_sad
		xml.funny_serious @ad.funny_serious
		xml.sexy_disgust @ad.sexy_disgust
	end
end
