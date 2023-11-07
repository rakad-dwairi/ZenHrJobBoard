# spec/models/job_post_spec.rb
require 'rails_helper'

RSpec.describe JobPost, type: :model do
  it "is valid with valid attributes" do
    job_post = build(:job_post)
    expect(job_post).to be_valid
  end

  it "has a default date_posted" do
    job_post = create(:job_post, date_posted: nil)
    expect(job_post.date_posted).to eq(Date.current)
  end
end
