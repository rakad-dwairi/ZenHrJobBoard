class JobPost < ApplicationRecord
    belongs_to :user
    before_validation :set_default_date, on: :create
  
    # Other model code
  
    private
  
    def set_default_date
      self.date_posted ||= Date.current
    end
  
  end
  