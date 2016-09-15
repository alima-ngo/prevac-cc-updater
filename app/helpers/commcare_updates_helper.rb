module CommcareUpdatesHelper
  def action_link u
    if u.active and u.cc_update_on == Date.today
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

end
