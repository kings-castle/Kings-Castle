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

  #trigger this method when attempting to make a valid move
  #pass desired endpoint on the board as the argument

  def move_to(y_pos, x_pos)
    #check if a piece exists at the endpoint
    #if there is no piece at the end point, relocate the piece and update the position
    #else if moving_piece and end_point_piece are the same color, do nothing
    #else the moving_piece and end_point_piece are not the same color, remove the piece from the board
  end


end

