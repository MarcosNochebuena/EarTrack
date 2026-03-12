# frozen_string_literal: true
# == Schema Information
#
# Table name: producers
#
#  id                 :integer          not null, primary key
#  upp_key            :string
#  producer_full_name :string
#  produced_adress    :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class ProducerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
