require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "availble games" do 
    it "should list games available to play" do 
      #arrange
      player1 = FactoryBot.create(:player)
      game = FactoryBot.create(:game, white_player_id: player1.id, black_player_id: nil)
      
      #act
      result = game.available_games(player1.id)

      #assert

    end
  end

end

