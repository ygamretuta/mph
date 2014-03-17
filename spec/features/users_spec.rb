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
end
