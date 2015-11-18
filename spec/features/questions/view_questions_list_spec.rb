require 'rails_helper'

feature 'View a list of questions', %q(
  In order to find a question
  As an user
  I want to have ability to view a list of questions
) do
  scenario 'User view a list of questions' do
    @questions = create_list(:question, 2)
    visit questions_path

    expect(page).to have_link 'MyString', href: question_path(@questions[0])
    expect(page).to have_link 'MyString', href: question_path(@questions[1])
  end
end
