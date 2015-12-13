require 'rails_helper'

feature 'Create question', %q(
  In order to get answer from community
  As an authenticated user
  I want to have ability to ask questions
) do
  given(:user) { create(:user) }

  scenario 'Authenticated user creates question with valid data' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test question'
    click_on 'Create'
    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Authenticated user tries to create question with invalid title' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Body', with: 'Test question'
    click_on 'Create'
    expect(page).to have_content "Title can't be blank"
  end

  scenario 'Authenticated user tries to create question with invalid body' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    click_on 'Create'
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Unauthenticated user tries to create question' do
    visit questions_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
