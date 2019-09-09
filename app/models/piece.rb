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

  #check if occupied spot is an opponent piece
  #call on a piece and pass x_pos and y_pos values of endpoint
  #for the current piece, is the piece located at the x,y endpoint an opponent piece?
  def self.opponent_piece?(x, y) #line 27 to 31 is is_obstructed method, beyond is capture
    #find and store opponent piece in a variable
    #use the find method to locate piece with specific coords
    #if the piece exists, return true obstructed

    #if a piece exists, use color_name method to test if it is opponent or not
    opponent_piece = Piece.all(:conditions => ["x_pos = ? and y_pos = ?", x, y])
      #test if opponent piece color and current piece color are different
      if opponent_piece.color_name != @piece.color_name
      #remove the opponent piece from the board, captured
      opponent_piece.update_attributes(x_pos: nil, y_pos: nil)
      #update x_pos and y_pos of current piece to equal x and y
      @piece.update_attributes(x_pos: x, y_pos: y)
    #else, if the pieces are the same color
    else
      puts "Your own piece is already in that spot, silly"
    end
  end

  #is obstrcuted method
  #use the find method to locate piece with specific coords
  if opponent_piece.color_name == @piece.color_name
  #if they are the same color, return true

  #capture logic
  #test if move is obstructed
  #if false, changes coords for pieces


  #check to see if the endpoint is occupied
  #pass x and y values of endpoint
  def self.space_empty?(x, y)
    #if there is a piece at the endpoint
    if piece.exist(:x_pos => x and :y_pos => y)
      #trigger opponent_piece method
      @piece.opponent_piece?
    #else, if the space is empty
    else
      #updates x_pos and y_pos of piece to equal x and y
      @piece.update_attributes(x_pos: x, y_pos: y)
    end
  end

end

