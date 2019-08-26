class GamesController < ApplicationController
	def index
	end

	def new
    @game = Game.new
	end

	def create
    @game = games.create(game_params)
	end

	def show
	end

  private

  def game_params
    params.require(:game).permit(:white_player_id, :black_player_id, :game_id)
  end
end
