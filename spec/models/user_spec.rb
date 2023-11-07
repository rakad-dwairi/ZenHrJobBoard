# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = build(:user) # Use FactoryBot to build a user
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "is not valid without a password" do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it "has a secure password" do
    user = build(:user)
    expect(user.authenticate("password")).to eq(user)
  end
end
