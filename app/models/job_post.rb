class JobPost < ApplicationRecord
    validates :expiry_date, presence: true
  end
  