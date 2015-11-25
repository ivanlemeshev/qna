require 'rails_helper'

feature 'Create answer', %q(
  In order to help
  As an authenticated user
  I want to have ability to answer questions
) do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user creates answer with valid data' do
    sign_in(user)
    write_answer(question)
    fill_in 'Body', with: 'Test answer'
    click_on 'Create Answer'
    expect(page).to have_content 'Your answer successfully created'
  end

  scenario 'Authenticated user tries to create answer with invalid body' do
    sign_in(user)
    write_answer(question)
    fill_in 'Body', with: nil
    click_on 'Create Answer'
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Unauthenticated user tries to create answer' do
    write_answer(question)
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
