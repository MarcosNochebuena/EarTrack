class AddEarringsCountToKeys < ActiveRecord::Migration[8.0]
  def change
    add_column :keys, :earrings_count, :integer, default: 0, null: false
  end
end
