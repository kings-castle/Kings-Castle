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

  #check to see if occupied spot is an opponent
  #call this method on a piece and pass the x and y values of endpoint
  def self.opponent_piece?(x, y)
    #find and store opponent piece in a variable
    opponent_piece = 
    #if the space is not empty and the piece and opponent piece are different colors
    #if I call this method in space_empty, remove the first condition
    if opponent_piece.color =! @piece.color
      #remove the opponent piece from the board
      opponent_piece.update_attributes(x_pos: nil, y_pos: nil)
      #updates x_pos and y_pos of piece to equal x and y
      @piece.update_attributes(x_pos: x, y_pos: y)
    else
      puts "Your own piece is already in that spot, silly"
    end
  end

  #check to see if the endpoint is occupied
  #pass x and y values of endpoint
  def space_empty?(x, y)
    #if there is a piece at the endpoint
    if piece.exist(:x_pos => x and :y_pos => y)
        #if the piece exists, report that space is not empty (false)
        puts false
        #trigger opponent_piece method
        @piece.opponent_piece?
    else
        #if the piece does not exist, report that the space is empty (true)
        #updates x_pos and y_pos of piece to equal x and y
        puts true
        @piece.update_attributes(x_pos: x, y_pos: y)
    end
  end

end

