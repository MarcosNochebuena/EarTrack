class CreateKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :keys do |t|
      t.string :num_key
      t.string :upp

      t.timestamps
    end
  end
end
