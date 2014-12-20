class AnswersController < ApplicationController

  def index
    @answers = Answer.all
  end

  def create
    answer = Answer.new(answer_params)
    if answer.save
      redirect_to question_path(answer.question)
    else
      @answer = answer
      @question = Question.find(@answer.question_id)
      render "/questions/show"
    end
  end

  def answer_params
    params.require(:answer).permit(:user_id, :question_id, :description)
  end

end
