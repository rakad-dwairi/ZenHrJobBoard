class JobPost < ApplicationRecord
    belongs_to :admin, class_name: 'User'
    has_many :job_applications
  
    validates :title, :description, presence: true
    validates :expiry_date, presence: true, future_date: true
  end
  