class RenameSettingsToProducers < ActiveRecord::Migration[7.0]
  def change
    rename_table :settings, :producers
  end
end
