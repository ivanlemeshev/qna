require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user)     { create :user }
  let(:question) { create :question, user: user }
  let(:answer)   { create :answer, question: question, user: user }

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'save the new answer in the database' do
        expect {
          post :create, question_id: question, answer: attributes_for(:answer), format: :js
        }.to change(question.answers, :count).by(1)
        expect(assigns(:answer).user).to eq @user
      end

      it 'render create template' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new answer in the database' do
        expect {
          post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        }.to_not change(Answer, :count)
      end

      it 'render create template' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    let(:user_answer) { create :answer, question: question, user: @user }

    before { user_answer }

    context 'author of answer' do
      it 'deletes answer' do
        expect { delete :destroy, id: user_answer }.to change(Answer, :count).by(-1)
      end

      it 'redirects to the question view' do
        delete :destroy, id: user_answer
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'non-author of answer' do
      sign_in_user

      it 'tries to delete answer' do
        expect { delete :destroy, id: user_answer }.to_not change(Answer, :count)
      end

      it 'redirects to the question view' do
        delete :destroy, id: user_answer
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
