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
      w = User.create(email: 'mattarrick@gmail.com', password: 'password')
      # game = Factorybot.create(:game)
      game = Game.create(name: 'User', white_player_id: 1, black_player_id: 1)
      # game.save
      # puts game
      # post :create, params: {
      #   game: { 
      #     name: 'User', 
      #     white_player_id: 1, 
      #     black_player_id: 2 
      #   }
      # }
      g = Game.last
      # games = Game.all
      # game = games[0]
      # puts games
      # expect(game.name).to eq("User")
      expect(g.white_player_id).to eq 1
    end

  end 
end