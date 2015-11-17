require 'rails_helper'

feature 'Create answer', %q(
  In order to help
  As an authenticated
  I want to have ability to answer questions
) do
  scenario 'Authenticated user creates answer'

  scenario 'Unauthenticated user tries to create answer'
end
