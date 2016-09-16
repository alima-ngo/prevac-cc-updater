module CommcareUpdatesHelper
  def action_link u
    if u.is_current?
      link_to "#{fa_icon('arrow-circle-right')} Continuer".html_safe,
        controller: 'commcare_updates', action: "step#{u.progress}", id: u
    else
      link_to "#{fa_icon('eye')} Voir".html_safe, u
    end
  end

  def date_label u
    if u.cc_update_on == Date.today
      "Aujourd'hui"
    elsif u.cc_update_on == Date.yesterday
      "Hier"
    else
      u.cc_update_on.strftime("%Y-%m-%d")
    end
  end

  def progress_label u
    return "#{fa_icon 'check'}".html_safe if u.progress == CommcareUpdate::COMPLETION_STEP
    "#{u.progress} / #{CommcareUpdate::MAX_STEPS}"
  end

end
