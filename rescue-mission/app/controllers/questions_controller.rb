
class QuestionsController < ApplicationController
  def index
    @questions = Question.order('created_at DESC')
  end

  def new
    @question = Question.new
  end

  def create
    question = Question.new(question_params)
    if question.save
      redirect_to '/questions'
    else
      # binding.pry
      @question = question
      render action: 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  private

  def question_params
    params.require(:question).permit(:user_id, :title, :description)
  end

end
