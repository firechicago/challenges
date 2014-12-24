<<<<<<< HEAD
=======
class QuestionsController < ApplicationController
  before_filter :authenticate!, :except => [:index, :show]
>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73

class QuestionsController < ApplicationController
  def index
<<<<<<< HEAD
    @questions = Question.order('created_at DESC')
=======
    @questions = Question.order("id DESC").all
>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73
  end

  def new
    @question = Question.new
<<<<<<< HEAD
=======
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      redirect_to "/questions/#{@question.id}"
    else
      render :edit
    end
  end

  def show
    @question = Question.find( params[:id] )
    unless @question.best_answer == nil
      @best_answer = Answer.find(@question.best_answer)
    end
    @answers = @question.answers.order("created_at DESC")
    @answer = Answer.new
>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73
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

<<<<<<< HEAD
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
=======
  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      redirect_to questions_path, :notice => "Your question has been deleted successfully."
    else

    end
>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73
  end

  private
  helper QuestionsHelper

  def question_params
    params.require(:question).permit(:user_id, :title, :description, :best_answer)
  end

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end

  def set_current_user(user)
    session[:user_id] = user.id
  end

  def authenticate!
    unless signed_in?
      redirect_to questions_path, :notice => 'You need to sign in if you want to do that!'
    end
  end

end
