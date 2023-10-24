require 'rails_helper'

RSpec.describe 'User Login', type: :feature do
  context 'As a registered user with good credentials' do
    let!(:user) { User.create(name: 'User Name', email: 'user@example.com', password: 'password', password_confirmation: "password") }

    it 'can log in and access the dashboard' do
      
      visit root_path
      click_link 'Log In'

      expect(current_path).to eq(login_path)

      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log In'

      expect(current_path).to eq(user_path(user))
      expect(page).to have_content("Welcome, #{user.name}")
    end
  end
  context 'As a registered user' do
    let!(:user) { User.create(name: 'User Name', email: 'user@example.com', password: 'password', password_confirmation: "password") }

    it 'fails to log in with incorrect credentials' do
      visit root_path
      click_link 'Log In'
      expect(current_path).to eq(login_path)

      fill_in 'Email', with: 'wronguser@example.com'
      fill_in 'Password', with: 'incorrect_password'
      click_button 'Log In'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Invalid Credentials')
    end
  end
end
