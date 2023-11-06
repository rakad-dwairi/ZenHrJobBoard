class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job_post

  validates :status, inclusion: { in: ['Not Seen', 'Seen'] }
end
