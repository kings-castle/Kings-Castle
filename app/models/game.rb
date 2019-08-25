class Game < ApplicationRecord
  has_many :players
  has_many :pieces



  def self.available_games(user_id)
  
  end
end

