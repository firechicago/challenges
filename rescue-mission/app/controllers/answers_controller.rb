class AnswersController < ApplicationController

  def index
    @answers = Answer.all
  end

<<<<<<< HEAD
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

=======
  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to @answer.question, notice: 'Answer was posted successfully.'
    else
      binding.pry
      @question = @answer.question
      @answers = @question.answers.order("created_at DESC")
      render "questions/show"
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:user_id, :question_id, :description, :favorite)
  end


>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73
end
