require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!({
      first_name: 'Usey',
      last_name: 'Userson',
      email: 'user@user.com',
      password: 'password',
      password_confirmation: 'password'
    })
  end

  scenario 'Logging in successfully takes user to home page' do
    # ACT
    visit '/login'

    within 'form' do
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_button 'Submit'
    end

    # DEBUG / VERIFY
    expect(page).to have_current_path('/')
    expect(page).to have_css('#navbar > ul > li > a', text: 'Logout')
    save_screenshot
  end
end
