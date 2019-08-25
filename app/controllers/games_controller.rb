class GamesController < ApplicationController
	def index
	end

	def new
    @game = Game.new
	end

	def create
    @game = Game.create(game_params)
	end

	def show
	end

  def update
    @game = Game.find_by_id(params[:id])
    @game.update_attributes(game_params)
  end

   private

  def game_params
    params.require(:game).permit(:white_player_id, :black_player_id, :game_id)
  end
end

