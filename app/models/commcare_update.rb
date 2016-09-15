class CommcareUpdate < ApplicationRecord
  MAX_STEPS = 5

  def completed?
    progress == MAX_STEPS
  end
end
