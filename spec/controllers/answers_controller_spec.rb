require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user)     { create :user }
  let(:question) { create :question, user: user }
  let(:answer)   { create :answer, question: question, user: user }

  describe 'GET #new' do
    sign_in_user

    before { get :new, question_id: question }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new Answer
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'save the new answer in the database' do
        expect {
          post :create, question_id: question, answer: attributes_for(:answer)
        }.to change(question.answers, :count).by(1)
        expect(assigns(:answer).user).to eq @user
      end

      it 'redirects to question show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new answer in the database' do
        expect {
          post :create, question_id: question, answer: attributes_for(:invalid_answer)
        }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, question_id: question.id, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
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
