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


private

#test if a move is a valid diagonal move
def diagonal_move?(axis)
  #define a method for slope
  #if slope is equal to 1 or -1, true
  #if slope is not equal to 1 or -1, false
end

#test if a valid diagonal path is obstructed
def diagonal_block?(axis)

  #if diagonal_move? = true

  #test if there are pieces on that slope causing an obstruction

    #if the endpoint x,y are both greater than starting x,y
      #test obstructin by adding 1 to each x and y
    #if the endpoint x,y are both less than starting x,y
      #test obstruction by subtracting 1 to each x and y
    #if the endpoint x is greater than starting x and endpoint y is less than starting y
      #test obstruction by adding 1 to x and subtracting 1 from y
    #if the endpoing x is less than starting x and endpoint y is greater than starting y
      #test obstruction by subtracting 1 from x and adding 1 to y

  #if there are pieces on the path, is obstructed = true
  #if the path is clear, is obstructed = false


  end


end

