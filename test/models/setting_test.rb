# == Schema Information
#
# Table name: settings
#
#  id                 :bigint           not null, primary key
#  produced_adress    :string
#  producer_full_name :string
#  upp_key            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "test_helper"

class SettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
