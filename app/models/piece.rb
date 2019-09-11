class Piece < ApplicationRecord
  attr_accessor :color, :postion


  belongs_to :game
  belongs_to :player #:user

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


#test for empty endpoint and move player
def move(x,y)
  #returns true if piece exists
  #returns false if piece does not exist
  endpoint_piece = Piece.exists?(:x_pos => x, :y_pos => y)
  #if the endpoint is empty
  if endpoint_piece == false
    #relocate the moving piece to the endpoint
    #update the x_pos and y_pos
    @piece.update_attributes(x_pos: x, y_pos: y)
  else
  end
end


#test for obstructed endpoint and move player
#captures piece at the current endpoint
#returns error if pieces are the same color
def capture(x,y)
  #returns true if piece exists
  #returns false if piece does not exist
  endpoint_piece = Piece.exists?(:x_pos => x, :y_pos => y)

  #if endpoint_piece returns true and the colors are the same
  if endpoint_piece == true && endpoint_piece.color_name == @piece.color_name
    puts "Your own piece is already in that spot, silly"

  #if the find_piece method returns true and the colors are different
  else endpoint_piece == true && endpoint_piece.color_name != @piece.color_name
    #update the x and y pos of opponent_piece to equal 0
    endpoint_piece.update_attributes(x_pos: nil, y_pos: nil)
    #update the x and y pos of moving piece to equal endpoint
    @piece.update_attributes(x_pos: x, y_pos: y)
  end
end

end

#practice with ways to query db for piece
    #Piece.where({ x_pos: x, y_pos: y})
    #Piece.where("x_pos = ? AND y_pos = ?", x, y)
    #Piece.where(x_pos: x, y_pos: y)
    #Piece.exists?(:x_pos => x, :y_pos => y) 



