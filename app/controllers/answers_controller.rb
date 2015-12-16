class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:destroy]
  before_action :only_owner, only: [:destroy]

  def create
    @answer = current_user.answers.new(answer_params)
    @answer.question = @question
    @answer.save
  end

  def destroy
    @answer.destroy
    redirect_to @answer.question, notice: I18n.t('notices.answers.removed')
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def only_owner
    redirect_to @answer.question, alert: I18n.t('alerts.access_denied') unless current_user.owner_of?(@answer)
  end
end
