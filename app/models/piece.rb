class Piece < ApplicationRecord
  attr_accessor :color, :postion


  belongs_to :game
  belongs_to :player #:user

  self.inheritance_column = :piece_type


  #Define is_obstructed? method
  def is_obstructed?(x_end, y_end)

  #Variable to store possible board move endpoints
    endpoint = Array.new(8) {Array.new(8, 0)}
    #Determine if chosen landing space is open
    return true if open_space?(x_end, y_end)
  end

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

  #Check that x axis value changes
  #Check that y axis value stays same
  #Check if x ending position is enemy occupied
  def horizontal_block?(x_axis)
    #Check if piece is moving left or right
    #Right
    if x_axis > self.x_pos
      (x_axis + self.x_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos + i + 1, y_pos: self.y_pos).is_empty?
        return true
      end
    #Left
    else  
      #Will return array
      #Left space check
      (x_axis - self.x_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos - i + 1, y_pos: self.y_pos).is_empty?
        return true
      end
    end
  end

  def vertical_block?(y_axis)
   if y_axis > self.y_pos
      (y_axis + self.y_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos, y_pos: self.y_pos + i + 1).is_empty?
        return true
      end
    else  
      #Will return array
      (y_axis - self.y_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos, y_pos: self.y_pos - i + 1).is_empty?
        return true
      end
    end
  end

  def diagonal_block?(x_axis, y_axis)
    #Diagonal right
    if x_axis > self.x_pos && y_axis > self.y_pos 

    #Diagonal left
    else

  end

  def open_space?(x_end, y_end)
    #Check if space is open
    self.game.pieces.where(x_pos: x_end, y_pos: y_end).is_empty?
  end

end

