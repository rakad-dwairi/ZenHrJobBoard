class User < ApplicationRecord
    has_many :job_applications
    has_many :job_posts
    require "securerandom"

    has_secure_password

    validates :email, presence: true, uniqueness: true

end
