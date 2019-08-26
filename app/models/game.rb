class Game < ApplicationRecord
  has_many :players
  has_many :pieces



  #sort available games for user to join
  def available_games
    #iterate through all available games
    #pull any game that has a black_player_id of nil
    #store pulled games in an array called available_games
    #return available_games
    Games.each do |game|
      if black_player_id == nil
        puts "Join Game"
      else
      end
    end
  end
  
end

