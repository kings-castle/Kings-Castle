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

  #reset the black_player_id in available games to equal the current_user.id
  def update
    @game = Game.find_by_id(params[:id])
    @game.update_attributes(black_player_id: current_user.id)
    redirect_to game_path
  end

  private

  def game_params
    params.require(:game).permit(:game_id, :name, :white_player_id, :black_player_id)
  end


 
end



