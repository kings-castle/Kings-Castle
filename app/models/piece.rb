class Piece < ApplicationRecord
  attr_accessor :color, :postion


  belongs_to :game
  belongs_to :player

  self.inheritance_column = :piece_type

  def self.piece_types
    %w(Pawn Rook Knight Bishop Queen King)
  end


#Verify piece color.  If the piece color is white the 'color' stays white
  #otherwise it changes to black

#The opposite of 'color' will be '!color'
#We can use 'color' and '!color' now in other methods
  def color_name
    color ? 'white' : 'black'
  end

#is_obstrcuted method- check to see if a piece exists at given endpoint
def self.is_obstructed?(x,y)
  #if a piece exists at the given coordinates, return true
  if piece.exist?(x_pos: x, y_pos: y)
    true
    #store the opponent piece
    opponent_piece = Piece.find_by(x_pos: x, y_pos: y)
  #if a piece does not exist at the given coordinates, return false
  else
    false
    #relocate piece to empty endpoint
    @piece.update_attributes(x_pos: x, y_pos: y)
end

#capture logic- test for color of obstructed piece and capture if opponent
def self.capture(x, y)
  #if the piece is obstructed and the colors are the same
  if @piece.is_obstructed? == true && opponent_piece.color_name == @piece.color_name
    #return statement that the pieces are the same
    puts "Your own piece is already in that spot, silly"
  #if the piece is obstructed and the colors are different 
  else
    #reassign the new piece and opponent piece location
    opponent_piece.update_attributes(x_pos: nil, y_pos: nil)
    @piece.update_attributes(x_pos: x, y_pos: y)
end



 