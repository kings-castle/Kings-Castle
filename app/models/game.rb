class Game < ApplicationRecord
  has_many :players
  has_many :pieces

  #set association between games and users
  belongs_to :white_player, class_name: 'User'
  belongs_to :black_player, class_name: 'User', optional: true

  #define a scope that sets user_id equal to the currently logged in user id
  #scope :available_games, -> { where(user_id == User.current_user.id)}

  #sort available games for user to join
  #call using Game.available_games(user_id)
  def self.available_games(user)
    #for all games with black_player_id of nil and white_player_id of user_id
    #store in array
    #executes all at db level
    #if there is a user available
    if user
      #return a query to sort games where black_player_id is nil and white_player_id is not equal to the user
      where("black_player_id = ? or white_player_id != ?", nil, user)
    #if there is not a user
    else
      #return a query to sort games where black_player_id is nil
      where("black_player_id = ?", nil)
    end
  end

  #define the black_player_id of an available game
  #call in the games#update method
  def assign_player
    #set the black_player_id equal to the current user
    #call the update_attributes method
    #pass arguments (black_player_id: current_user.id)

  end

end

