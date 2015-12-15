FactoryGirl.define do
  factory :question do
    title 'MyQuestion'
    body 'MyQuestionText'
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
