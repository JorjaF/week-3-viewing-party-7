require 'rails_helper'

RSpec.describe 'Logging out as a user', type: :feature do
  it 'logs out and sees the Log In link' do
    
    user = User.create(name: 'User Name', email: 'user@example.com', password: 'password', password_confirmation: "password")
    visit login_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log In'

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, #{user.name}")
    
    click_link "Home"

    expect(page).to have_link('Log Out')
    expect(page).not_to have_link('Log In')
    expect(page).not_to have_link('Create an Account')

    # Click the Log Out link
    click_link 'Log Out'

    # Verify that the user is redirected to the landing page and sees the Log In link again
    expect(current_path).to eq(root_path)
    expect(page).to have_link('Log In')
    expect(page).not_to have_link('Log Out')
  end
end
