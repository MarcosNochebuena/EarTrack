# == Schema Information
#
# Table name: keys
#
#  id          :bigint           not null, primary key
#  num_key     :string
#  upp         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  producer_id :bigint
#
# Indexes
#
#  index_keys_on_producer_id  (producer_id)
#
# Foreign Keys
#
#  fk_rails_...  (producer_id => producers.id)
#
require 'test_helper'

class KeyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
