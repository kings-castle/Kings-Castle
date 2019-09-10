require 'rails_helper'

#w = User.create(email: 'mattarrick@gmail.com', password: 'password')
      #game = Game.create(name: 'User', white_player_id: 1, black_player_id: 1)
      #g = Game.last
      #expect(game.name).to eq("User")
RSpec.describe Piece, type: :model do
  describe "is_obstructed method" do 
    it "should relocate the piece if false" do 
      #arrange
      user1 = User.create(email: "test@gmail.com", password: "test1234", password_confirmation: "test1234")
      game1 = Game.create(name: "testgame", white_player_id: 1, black_player_id: 2)
      piece1 = Piece.create(piece_type: "King", x_pos: 4, y_pos: 5)
      piece2 = Piece.create(piece_type: "King", x_pos: 2, y_pos: 3)
      #act
      result = piece2.is_obstructed?(5,0)
      #assert
      expect(result).to eq(false)
    end
  end

  describe "is_obstructed method" do 
    it "should store the opponent piece if true" do 
    end
  end

  describe "capture method" do 
    it "should do nothing if the colors are the same" do
    end
  end

  describe "capture method" do 
    it "should relocate the piece and remove the opponent if the colors are different" do 
    end
  end
end
