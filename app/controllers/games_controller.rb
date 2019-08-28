class GamesController < ApplicationController
	def index
    @games = Game.available_games(current_user)
	end

	def new
    @game = Game.new
	end

	def create
    @game = game.create(game_params)
	end

	def show
	end

  private

  def game_params
    params.require(:game).permit(:white_player_id, :black_player_id, :game_id)
  end
end
