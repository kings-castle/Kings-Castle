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
    # UPDATE Matt Arrick 9/21/19
      # Black player_id is now updating when a player joins a game
        # Added 'update_player_id' method to the piece model that finds pieces 
        # that are nil and belong to the current_game and then updates that player_id
        # with the current_user. (↓↓↓)
    @piece = Piece.update_player_id(current_user, current_game)
    #redictect to the game path
    redirect_to game_path
  end

  private

  def game_params
    params.require(:game).permit(:game_id, :name, :white_player_id, :black_player_id)
  end


  # UPDATE Matt Arrick 9/21/19
    # Added a helper_method to get the current_game
  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end
 
end



