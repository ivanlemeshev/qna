require 'rails_helper'

feature 'User sign out', %q(
  In order to be able to exit from the system
  As an authenticated user
  I want to have ability to sign out
) do
  scenario 'Authenticated user try to sign out' do
    sign_in(create(:user))
    click_on 'Sign out'
    expect(page).to have_content 'Signed out successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Unauthenticated user try to sign out' do
    visit root_path
    expect(page).to have_content 'Sign in'
    expect(page).to have_no_content 'Signed out'
  end
end
