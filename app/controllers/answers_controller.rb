class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:new, :create]

  def new
    @answer =  @question.answers.new
  end

  def create
    @answer = current_user.answers.new(answer_params)
    @answer.question = @question

    if @answer.save
      redirect_to @question, notice: I18n.t('notices.answers.created')
    else
      render 'new'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])

    if current_user.owner_of?(@answer)
      @answer.destroy
      redirect_to @answer.question, notice: I18n.t('notices.answers.destroyed')
    else
      redirect_to @answer.question, alert: I18n.t('alerts.access_denied')
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
