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
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      my_game = FactoryBot.create(:game, white_player_id: user.id)

      #act
      #result = my_game.update
      patch :update, params: {black_player_id: user2.id}

      #assert

    end
  end
end