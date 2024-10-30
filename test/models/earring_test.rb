# == Schema Information
#
# Table name: earrings
#
#  id         :bigint           not null, primary key
#  age        :integer
#  earring    :integer
#  gender     :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  key_id     :bigint           not null
#
# Indexes
#
#  index_earrings_on_key_id  (key_id)
#
# Foreign Keys
#
#  fk_rails_...  (key_id => keys.id)
#
require "test_helper"

class EarringTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
