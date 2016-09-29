class AddNewPidsToCommcareUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :commcare_updates, :new_pids, :string
  end
end
