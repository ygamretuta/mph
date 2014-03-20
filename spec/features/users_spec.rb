require 'spec_helper'

feature "Users" do
  scenario 'devise has custom params' do
    visit new_user_registration_path
    fill_in 'user[username]', with:'julyandaya'
    fill_in 'user[email]', with:'julyandaya@gmail.com'
    fill_in 'user[password]', with:'randompassword'
    fill_in 'user[password_confirmation]', with:'randompassword'
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'login using username' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Login', with:user.username
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end
end
