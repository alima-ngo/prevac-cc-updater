class Beneficiary < ApplicationRecord
  has_one :enrollment_data, :foreign_key => "PID"
end
