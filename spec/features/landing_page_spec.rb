require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "password", password_confirmation: "password")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "password", password_confirmation: "password")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users' do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "password", password_confirmation: "password")
    user1 = User.find_by(email: "user1@test.com")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "password", password_confirmation: "password")
    visit '/login'

    fill_in :Email, with: 'user1@test.com'
    fill_in :Password, with: 'password'
    click_button 'Log In'
    
    expect(current_path).to eq(user_path(user1))

    click_link "Home"

    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end 
end
