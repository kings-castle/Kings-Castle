require 'rails_helper'


RSpec.describe Piece, type: :model do
  
  describe "move method" do 
    it "return true or false if piece exists" do 
      #arrange
      user1 = User.create(email: "test@gmail.com", password: "test1234", password_confirmation: "test1234")
      game1 = Game.create(name: "testgame", white_player_id: 1, black_player_id: 2)
      piece = Piece.create(piece_type: "King", x_pos: 7, y_pos: 4)
      #act
      result = piece.move(5,0)
      #assert
      expect(result).to eq(false)
    end
  end

  describe "move method" do 
    it "should update the x and y pos of moving piece if the space is empty" do 
      #arrange
      user1 = User.create(email: "test@gmail.com", password: "test1234", password_confirmation: "test1234")
      game1 = Game.create(name: "testgame", white_player_id: 1, black_player_id: 2)
      piece = Piece.create(piece_type: "King", x_pos: 7, y_pos: 4)
      #act
      result = piece.move_to_empty_space(5,0)
      #assert
      expect(result).to eq(#test that piece x and y are equal to 5 and 0)
    end
  end


  describe "capture method" do 
    it "should relocate the piece and remove the opponent if the colors are different" do 
    #arrange
    #act
    #assert
    end
  end


  describe "capture method" do 
    it "should do nothing if the colors are the same" do
    #arrange
    #act
    #assert 
    end
  end

  


end
