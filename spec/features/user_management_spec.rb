require 'rails_helper'

RSpec.describe 'User Management' do
  it 'requires a user to be logged in to access the dashboard' do
    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You must be logged in or registered to access this feature.')
  end

  context 'As a registered user' do
    let!(:user1) { User.create(name: 'User One', email: 'user1@example.com', password: 'password', password_confirmation: 'password') }
    let!(:user2) { User.create(name: 'User Two', email: 'user2@example.com', password: 'password', password_confirmation: 'password') }

    before do
      visit login_path
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: 'password'
      click_button 'Log In'
    end

    it 'displays a list of existing users with email addresses (not clickable)' do
      expect(current_path).to eq(user_path(user1))

      click_link 'Home'

      expect(page).to have_content('Existing Users')

      within('.existing-users') do
        expect(page).to have_content(user1.email)
        expect(page).to have_content(user2.email)
        expect(page).not_to have_link(user1.email)
        expect(page).not_to have_link(user2.email)
      end
    end
  end
end
