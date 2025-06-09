# frozen_string_literal: true
# == Schema Information
#
# Table name: earrings
#
#  id         :integer          not null, primary key
#  key_id     :integer          not null
#  earring    :integer
#  status     :integer
#  age        :integer
#  gender     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_earrings_on_key_id  (key_id)
#

require 'test_helper'

class EarringTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
