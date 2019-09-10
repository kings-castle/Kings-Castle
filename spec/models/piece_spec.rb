require 'rails_helper'


RSpec.describe Piece, type: :model do
  describe "is_obstructed method" do 
    it "should relocate the piece if false" do 
      #arrange
      user1 = FactoryBot.create(:user)
      piece1 = FactoryBot.create(:piece)
      #act
      #assert
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
