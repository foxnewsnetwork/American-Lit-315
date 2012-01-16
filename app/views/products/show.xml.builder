xml.instruct!
xml.response do
	xml.company do
		xml.id @company.id
		xml.name @company.name
	end
	xml.product do
		xml.id @product.id
		xml.name @product.name
		xml.description @product.description
		xml.meta_data @product.meta_data 
	end
end

