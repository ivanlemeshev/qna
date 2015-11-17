require 'rails_helper'

feature 'View question with a list of answers', %q(
  In order to find best answer on question
  As an user
  I want to have ability to view questions with a list of answers
) do
  given(:user) { create(:user) }

  scenario 'View question with a list of answers'
end
