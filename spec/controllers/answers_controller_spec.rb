require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create :answer }
  let(:question) { create :question }

  describe 'GET #new' do
    before { get :new, question_id: question.id }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new Answer
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end
end
