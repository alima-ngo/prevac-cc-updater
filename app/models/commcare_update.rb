class CommcareUpdate < ApplicationRecord
  MAX_STEPS = 5
  COMPLETION_STEP = MAX_STEPS + 1

  def self.on_going_update?
    a = CommcareUpdate.where("cc_update_on = :date AND progress < :completion_step", {date: Date.today, completion_step: COMPLETION_STEP})
    a.size == 1
  end

  def is_current?
    cc_update_on == Date.today and progress != COMPLETION_STEP
  end

  def status_class
    if is_current?
      "success"
    elsif progress != COMPLETION_STEP
      "danger"
    else
      ""
    end
  end

end
