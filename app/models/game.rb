class Game < ApplicationRecord
  has_many :players
  has_many :pieces



  def self.available_games(user_id)
  
  end


  #def available_games
    #call all games
    #Games.each do |game|
      #look up each game by the game_id
      #@game = Game.find_by_id(params[:id])
      #test if black player id is nil and return results
      #if black_player_id == nil
        #puts "Game number #{game.game_id} is ready to play!"
      #else
        #puts "Game Unavailable"
      #end
    #end
  #end

  
end

