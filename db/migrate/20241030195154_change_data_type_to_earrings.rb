class ChangeDataTypeToEarrings < ActiveRecord::Migration[7.0]
  def change
    change_column :earrings, :status, :integer, using: 'status::integer'
    change_column :earrings, :gender, :integer, using: 'gender::integer'
  end
end