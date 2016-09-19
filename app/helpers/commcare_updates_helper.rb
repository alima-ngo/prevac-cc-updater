module CommcareUpdatesHelper
  def action_link u
    l = []
    if u.is_current?
      l = [
        link_to("#{fa_icon('arrow-circle-right')} Continuer".html_safe,
        {controller: 'commcare_updates', action: "edit", id: u.id, step: u.progress}, {class: "btn btn-primary btn-xs"}),
        link_to("#{fa_icon('eye')} Voir".html_safe, u, class: "btn btn-primary btn-xs")
      ]
    else
      l = [link_to("#{fa_icon('eye')} Voir".html_safe, u, class: "btn btn-primary btn-xs")]
    end
    l.join(' ').html_safe
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

  def status_class u
    if u.is_current?
      "info"
    elsif u.progress != CommcareUpdate::COMPLETION_STEP
      "danger"
    else
      ""
    end
  end

end
