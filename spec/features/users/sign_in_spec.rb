require 'rails_helper'

feature 'User sign in', %q(
  In order to be able to ask question
  As an authenticated user
  I want to have ability to sign in
) do
  given(:user) { create(:user) }

  scenario 'Registered user try to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Registered user try to sign in with invalid password' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'invalid'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'Registered user try to sign in with invalid email' do
    visit new_user_session_path
    fill_in 'Email', with: 'invalid@test.com'
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'Unregistered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end
end
