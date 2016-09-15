class CommcareUpdate < ApplicationRecord
  MAX_STEPS = 5

  def status_class
    if active and cc_update_on == Date.today
      "success"
    elsif progress != MAX_STEPS
      "danger"
    else
      ""
    end
  end

end
