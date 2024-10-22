class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.string :upp_key
      t.string :producer_full_name
      t.string :produced_adress

      t.timestamps
    end
  end
end
