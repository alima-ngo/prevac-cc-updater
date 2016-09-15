class CreateCommcareUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :commcare_updates do |t|
      t.datetime :cc_update_on
      t.integer :progress
      t.boolean :active

      t.timestamps
    end
  end
end
