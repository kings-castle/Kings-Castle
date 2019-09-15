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



### Added by Samantha Lee 9/15/2019

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

### End addition by Samantha Lee 9/15/2019

end





