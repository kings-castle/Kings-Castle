require 'rails_helper'

RSpec.describe GamesController, type: :controller do 
  describe "games#indxex action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end  

  describe "games#update action" do 
    it "should update the white_player_id of available games to the current user" do 
      #arrange
      player = FactoryBot.create(:player)
      player2 = FactoryBot.create(:player)
      my_game = FactoryBot.create(:game, white_player_id: player.id, black_player_id: nil, game_id: 1)

      #act
      result = my_game.update

      #assert

    end
  end
end