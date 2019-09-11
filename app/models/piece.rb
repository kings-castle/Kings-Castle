class Piece < ApplicationRecord
  attr_accessor :color, :x_pos, :y_pos
                        #changed the attr_accessor :position to x_pos and y_pos fields in the db---Matt Arrick 9/11/19

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

end

