require 'rails_helper'

feature 'View question with a list of answers', %q(
  In order to find best answer on question
  As an user
  I want to have ability to view questions with a list of answers
) do
  given(:question_author) { create(:user) }
  given(:answer_author1)  { create(:user) }
  given(:answer_author2)  { create(:user) }
  given(:question)        { create(:question, user: question_author) }
  given(:answer1)         { create(:answer, question: question, user: answer_author1) }
  given(:answer2)         { create(:answer, question: question, user: answer_author2) }

  scenario 'View question with a list of answers' do
    visit question_path(question)

    expect(page).to have_content question.body
    expect(page).to have_content answer1.body
    expect(page).to have_content answer2.body
  end
end
