require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create :user }

  describe 'GET #index' do
    let(:questions) { create_list :question, 2, user: user }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:question) { create :question, user: user }

    before { get :show, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'when user is an authenticated' do
      sign_in_user

      let(:question) { create :question, user: user }

      before { get :new }

      it 'assigns a new Question to @question' do
        expect(assigns(:question)).to be_a_new Question
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'when user is an unauthenticated' do
      before { get :new }

      it 'not assigns a new Question to @question' do
        expect(assigns(:question)).to eq nil
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    sign_in_user

    let(:question) { create :question, user: @user }

    before { get :edit, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
      expect(question.user).to eq @user
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user

    let(:question) { create :question, user: @user }

    context 'with valid attributes' do
      it 'save the new question in the database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
        expect(assigns(:question).user).to eq @user
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new question in the database' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    let(:question) { create :question, user: @user }

    context 'with valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it 'changes the question attributes' do
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to the update question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, id: question, question: { title: 'new title', body: nil } }

      it 'does not change the question attributes' do
        question.reload
        expect(question.title).to eq 'MyQuestion'
        expect(question.body).to eq 'MyQuestionText'
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    let(:user_question) { create :question, user: @user }

    before { user_question }

    context 'author of question' do
      it 'deletes question' do
        expect { delete :destroy, id: user_question }.to change(Question, :count).by(-1)
      end

      it 'redirects to the index view' do
        delete :destroy, id: user_question
        expect(response).to redirect_to questions_path
      end
    end

    context 'non-author of question' do
      sign_in_user

      it 'tries to delete question' do
        expect { delete :destroy, id: user_question }.to_not change(Question, :count)
      end

      it 'redirects to the index view' do
        delete :destroy, id: user_question
        expect(response).to redirect_to question_path(user_question)
      end
    end
  end
end
