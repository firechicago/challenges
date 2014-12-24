class CharactersController < ApplicationController
  def new
    @character = Character.new
    @television_show = TelevisionShow.find(params[:television_show_id])
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      flash[:notice] = "Success!"
      redirect_to "/television_shows/#{@character.television_show_id}"
    else
      flash.now[:notice] = "Your character couldn't be saved."
      @television_show = TelevisionShow.find(params[:television_show_id])
      render :new
    end
  end

  private

  def character_params
    params.require(:character).permit(:character_name, :actor_name, :description, :television_show_id)
  end
end
