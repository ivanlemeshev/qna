require 'rails_helper'

feature 'User sign up', %q(
  In order to be able to ask question
  As an authenticated user
  I want to have ability to sign up
) do
  scenario 'Authenticated user try to sign up'

  scenario 'Unauthenticated user try to sign up'

  scenario 'Registered user try to confirm registration'
end
