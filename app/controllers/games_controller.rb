class GamesController < ApplicationController
	def index
    # @games = Game.available_games(current_user)
	end

	def new
    @game = Game.new
	end

	def create
    @game = Game.create(game_params)
    redirect_to games_path
	end

	def show
    @game = Game.find_by_id(params[:id])
	end

  private

  def game_params
    params.require(:game).permit(:name, :white_player_id, :black_player_id)
  end
end
