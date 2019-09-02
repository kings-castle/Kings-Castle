require 'rails_helper'
require 'factory_bot'

RSpec.describe GamesController, type: :controller do 
  describe "games#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end 

  describe "games#create action" do
    it "should successfully create a new game in our database" do
      # game = Factorybot.create(:game)
      # game = Game.create(white_player_id: 1, black_player_id: 2, game_id: 3)
      post :create, params: {
        game: { 
          name: 'User', 
          white_player_id: 1, 
          black_player_id: 2 
        }
      }
      game = Game.last
      # expect(game.name).to eq("User")
      expect(game.white_player_id).to eq 1
    end

  end 
end