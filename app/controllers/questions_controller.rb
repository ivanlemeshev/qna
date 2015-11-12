class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end
end
