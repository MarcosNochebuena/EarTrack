class AddProducerIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :producer, foreign_key: true
  end
end
