require "rails_helper"

RSpec.describe "User Management" do
  it "requires a user to be logged in to access the dashboard" do
    # @user1 = User.create(name: "Bob Uno", email: "bobuno@abc.com", password: "password", password_confirmation: "password")
        visit root_path
    
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You must be logged in or registered to access this feature.")
  end
end
