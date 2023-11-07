# spec/models/job_application_spec.rb
require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  it "is valid with valid attributes" do
    job_application = build(:job_application)
    expect(job_application).to be_valid
  end

  it "is not valid without an application date" do
    job_application = build(:job_application)
    expect(job_application).to be_valid
  end

  it "has a default application_status of 'Not Seen'" do
    job_application = create(:job_application)
    expect(job_application.status).to eq("Not Seen")
  end

  it "allows changing application status to 'Seen' by an admin user" do
    job_application = create(:job_application)
    admin_user = create(:admin_user)
    job_application.user = admin_user
    job_application.status = "Seen"
    job_application.save
    expect(job_application.status).to eq("Seen")
  end
end
