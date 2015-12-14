require 'rails_helper'

feature 'Delete question', %q(
  In order to delete my question
  As an author of question
  I want to have ability to delete my questions
) do
  given(:author)     { create :user }
  given(:non_author) { create :user }
  given(:question)   { create :question, user: author }

  scenario 'Author of question tries to remove it' do
    sign_in(author)
    visit question_path(question)
    click_on 'Remove question'
    expect(page).to have_content 'Your question successfully removed'
    expect(current_path).to eq questions_path
    expect(page).to_not have_content question.title
  end

  scenario 'Non author of question tries to remove it' do
    sign_in(non_author)
    visit question_path(question)
    expect(page).to_not have_content 'Remove answer'
  end
end
