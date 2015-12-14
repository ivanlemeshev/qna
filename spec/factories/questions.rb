FactoryGirl.define do
  sequence :id

  factory :question do
    id
    title 'MyQuestion'
    body 'MyQuestionText'
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
