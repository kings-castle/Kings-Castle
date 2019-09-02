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
    #locate the id of the current game
    @game = Game.find_by_id(params[:id])
    #call the assign_player method on the current game using the current_user 
    @game = Game.assign_player(current_user)
    #redictec to the game path
    redirect_to game_path
  end

  private

  def game_params
    params.require(:game).permit(:game_id, :name, :white_player_id, :black_player_id)
  end


 
end



