class Game < ApplicationRecord
  has_many :players
  has_many :pieces



  def self.available_games(user_id)
    Games.each do |game|
      if black_player_id == nil
        puts "Join Game"
      else
      end
    end
  end
  
end

