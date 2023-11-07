FactoryBot.define do
    factory :job_post do
      user { create(:admin_user) } # Create an admin user using FactoryBot
      title { Faker::Job.title }
      description { Faker::Lorem.paragraph }
      date_posted { Date.current }
    end
  end
  