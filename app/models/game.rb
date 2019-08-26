class Game < ApplicationRecord
  has_many :players
  has_many :pieces



  #sort available games for user to join
  def self.available_games(user_id)
    #build an array to store available games
    available_games = []
    #iterate through all available games
    Games.each do |game|
      #pull any game that has a black_player_id of nil and
      #white_player_id does not equal the user
      if black_player_id == nil && white_player_id =! user_id
        #store pulled games in an array called available_games
        available_games << @game
        #return available_games
        puts available_games
      else
      end
    end
  end
  
end

