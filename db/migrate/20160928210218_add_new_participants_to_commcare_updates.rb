class AddNewParticipantsToCommcareUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :commcare_updates, :new_participants, :text
    add_column :commcare_updates, :new_reminders, :text
  end
end
