
FactoryBot.define do
    factory :user do
        email { Faker::Internet.email(domain: 'jobboard.com') }
        password { "password" } # Set a default password for testing
        role { "jobseeker"}
    end

    factory :admin_user, class: User do
      email { Faker::Internet.email(domain: 'jobboard_admin.com') }
      password { "password" }
      role { "admin" }
    end
  
    factory :job_seeker_user, class: User do
      email { Faker::Internet.email(domain: 'jobboard_jobseeker.com') }
      password { "password" }
      role { "jobseeker" }
    end
  end
  