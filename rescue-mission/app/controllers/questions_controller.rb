
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
      @question = question
      render action: 'new'
    end
  end

  def update
    @question = Question.update(params[:id], question_params)
    if @question.save
      redirect_to "/questions/#{@question.id}"
    else
      render action: 'edit'
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer ||= Answer.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  private

  def question_params
    params.require(:question).permit(:user_id, :title, :description)
  end

end
