class Answer < ActiveRecord::Base
  validates :body, :question_id, presence: true
end
