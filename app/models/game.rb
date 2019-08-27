class Game < ApplicationRecord
  has_many :players
  has_many :pieces

  #set association between games and users
  belongs_to :user

  #define a scope that sets user_id equal to the currently logged in user id
  scope :available_games, -> { where(user_id == User.current_user.id)}

  #sort available games for user to join
  #call using Game.available_games(user_id)
  def self.available_games(user_id)
    #set user_id equal to the current user
    #does this need to exist outside of the method?
    user_id = current_user.id
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

