class CreateEarrings < ActiveRecord::Migration[7.0]
  def change
    create_table :earrings do |t|
      t.references :key, null: false, foreign_key: true
      t.integer :earring
      t.string :status
      t.integer :age
      t.string :gender

      t.timestamps
    end
  end
end
