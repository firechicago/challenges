class CharactersController < ApplicationController
  def new
    @character = Character.new
  end

  def create
  end
end
