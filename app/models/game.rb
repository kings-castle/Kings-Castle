class Game < ApplicationRecord
  has_many :players
  has_many :pieces

  scope :available_games, -> {where(user_id => current_user.id)}

  #sort available games for user to join
  #call using Game.available_games(user_id)
  def self.available_games(user_id)
    #set user_id equal to the current user
    user_id = current_user.user_id
    #test if user_id is set to current_user
    puts user_id
    #call all games
    @games = Game.all
    #iterate through all games
    @games.each do |game|
      #pull any game that has a black_player_id of nil and
      #white_player_id does not equal the user
      if black_player_id == nil && white_player_id != user_id
        #return the game_id of all available_games
        puts @game.id
      else
      end
    end
  end
  
end

