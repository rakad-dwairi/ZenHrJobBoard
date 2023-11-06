class User < ApplicationRecord
    has_secure_password
  
    has_many :job_applications
    has_many :job_posts, through: :job_applications
  
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }
  
    def admin?
      admin
    end
  end
  