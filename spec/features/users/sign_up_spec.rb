require 'rails_helper'

feature 'User sign up', %q(
  In order to be able to ask question
  As an authenticated user
  I want to have ability to sign up
) do
  given(:user) { create(:user) }

  scenario 'New user try to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'new@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'A message with a confirmation link has been sent to your email address.
                                  Please follow the link to activate your account.'
    expect(current_path).to eq root_path
  end

  scenario 'New user try to sign up with already taken email' do
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
    expect(current_path).to eq user_registration_path
  end

  scenario 'New user try to sign up with blank email' do
    visit new_user_registration_path
    fill_in 'Email', with: nil
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content "Email can't be blank"
    expect(current_path).to eq user_registration_path
  end

  scenario 'New user try to sign up with invalid email' do
    visit new_user_registration_path
    fill_in 'Email', with: 'wrong_email'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'Email is invalid'
    expect(current_path).to eq user_registration_path
  end

  scenario 'New user try to sign up with blank password' do
    visit new_user_registration_path
    fill_in 'Email', with: 'new@test.com'
    fill_in 'Password', with: nil
    fill_in 'Password confirmation', with: nil
    click_on 'Sign up'

    expect(page).to have_content "Password can't be blank"
    expect(current_path).to eq user_registration_path
  end

  scenario 'New user try to sign up with invalid password confirmation' do
    visit new_user_registration_path
    fill_in 'Email', with: 'new@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: nil
    click_on 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(current_path).to eq user_registration_path
  end
end
