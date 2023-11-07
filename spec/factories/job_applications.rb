FactoryBot.define do
  factory :job_application do
    user { create(:job_seeker_user) } # Create a job seeker user using FactoryBot
    job_post { create(:job_post) }
    application_date { Date.current }
    status { "Not Seen" }
  end
end
