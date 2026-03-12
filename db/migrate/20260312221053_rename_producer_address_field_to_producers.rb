class RenameProducerAddressFieldToProducers < ActiveRecord::Migration[8.0]
  def change
    rename_column :producers, :produced_adress, :produced_address
  end
end
