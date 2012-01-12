# == Schema Information
#
# Table name: products
#
#  id             :integer(4)      not null, primary key
#  company_id     :integer(4)
#  ext_product_id :integer(4)
#  name           :string(255)
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Product do
  pending "add some examples to (or delete) #{__FILE__}"
end
