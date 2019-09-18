class Piece < ApplicationRecord
  attr_accessor :color, :postion

  #sets associations with pieces to game and player
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

#allows you to find a test a piece in a game
#returns array of the piece at the given x,y location
def find_piece(x,y)
  piece = self.game.pieces.where(x_pos: x, y_pos: y)
  puts piece
end


#test for empty endpoint and move player if the spot is empty
def move(x,y)
  #returns true if piece exists
  #returns false if piece does not exist
  endpoint_piece = Piece.exists?(:x_pos => x, :y_pos => y)
  #if the endpoint is empty, or the piece does not exist
  if endpoint_piece == false
    #relocate the moving piece to the endpoint
    #update the x_pos and y_pos
    self.update_attributes(:x_pos => x, :y_pos => y)
  #if the piece does exist, do nothing
  else
  end
end


#test for occupied endpoint
#captures piece at the current endpoint if the player_ids are different
#returns error if the player_ids are the same
def capture(x,y)
  #locates piece at endpoint
  endpoint = self.game.pieces.find_by_x_pos_and_y_pos(x,y)
  #tests accurate location and access to object
  #endpoint.player_id
  #if a piece exists at the endpoint and the player_ids are the same
  if endpoint != nil && endpoint.player_id == self.player_id
    #lets the user know their piece is already in that spot
    puts "Your own piece is already in that spot, silly"
  #if a piece exists at the endpoint and the player_ids are different
  elsif endpoint != nil && endpoint.player_id != self.player_id
    #update the x and y pos of endpoint piece to equal 0, remove piece from the board
    endpoint.update_attributes(:x_pos => nil, :y_pos => nil)
    #update the x and y pos of moving piece to equal endpoint, relocate the moving piece
    self.update_attributes(:x_pos => x, :y_pos => y)
  else
  end
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
        #return false, there is no horizontal block and piece can move
        return false
      end
    #Left
    else  
      #Will return array
      #Left space check
      (x_axis - self.x_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos - i + 1, y_pos: self.y_pos).is_empty?
        #return false, there is no horizontal block and piece can move
        return false
      end
    end
  end

  def vertical_block?(y_axis)
   if y_axis > self.y_pos
      (y_axis + self.y_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos, y_pos: self.y_pos + i + 1).is_empty?
        #return false, there is no vertical block and piece can move
        return false
      end
    else  
      #Will return array
      (y_axis - self.y_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos, y_pos: self.y_pos - i + 1).is_empty?
        #return false, there is no vertical block and piece can move
        return false
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

