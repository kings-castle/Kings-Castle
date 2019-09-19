class GamesController < ApplicationController

  def index
    @games = Game.available_games(current_user)
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

  #reset the black_player_id in available games to equal the current_user.id
  def update
    #locate the id of the current game
    @game = Game.find_by_id(params[:id])
    #call the assign_player method on the current game using the current_user 
    @game = Game.assign_player(current_user)
    # UPDATE Matt Arrick 9/18/19
      # I tried to update the player_id for black pieces when user joins.
        # The above code (↑↑) works to update the game.black_player_id but
        # at the moment the below code (↓↓) does not update the player_id for 
        # black pieces in the pieces table.  However, it also does not error.
        # We'll need to come back to this to ensure the black pieces recieve
        # the proper user.id.
    @piece = Piece.where(["player_id = ? and game_id = ?", nil, Game.find_by_id(params[:id])]).update_all(player_id: current_user.id)
    #redictect to the game path
    redirect_to game_path
  end

  private

  def game_params
    params.require(:game).permit(:game_id, :name, :white_player_id, :black_player_id)
  end


 
end



