class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
    if !current_user.owner_of?(@question)
      redirect_to @question, alert: I18n.t('alerts.access_denied')
    end
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: I18n.t('notices.questions.created')
    else
      render 'new'
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: I18n.t('notices.questions.updated')
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.owner_of?(@question)
      @question.destroy
      redirect_to questions_path, notice: I18n.t('notices.questions.removed')
    else
      redirect_to @question, alert: I18n.t('alerts.access_denied')
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
