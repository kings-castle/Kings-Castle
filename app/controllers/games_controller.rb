class GamesController < ApplicationController
	def index
	end

	def new
	end

	def create
	end

	def show
	end

  def update
    #call the current game
    @game = Game.find_by_id(params[:id])
    #update attributes based on game parameters
    @game.update_attributes(game_params)
  end
end

