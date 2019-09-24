class Piece < ApplicationRecord
  # attr_accessor :color, :postion

  #sets associations with pieces to game and player
  belongs_to :game
  belongs_to :player, optional: true #UPDATE Matt Arrick 9/18/19 
                                        # Added 'optional: true' to allow nil player_id for black pieces upon game creation

  self.inheritance_column = :piece_type

  #Define is_obstructed? method
  def is_obstructed?(x_end, y_end)

  #Variable to store possible board move endpoints
    endpoint = Array.new(8) {Array.new(8, 0)}
    #Determine if chosen landing space is open
    #return true if open_space?(x_end, y_end)
    if self.horizontal_block?(x_end) == false && self.vertical_block?(y_end) == false
      false
    else
      true
    end
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

 # UPDATE Matt Arrick 9/21/19
      # Black player_id is now updating when a player joins a game
        # Added 'update_player_id' method to the piece model that finds pieces 
        # that are nil and belong to the current_game and then updates that player_id
        # with the current_user. (↓↓↓)
  def self.update_player_id(user, current_game)
    piece = self.where(player_id: nil, game_id: current_game.id).update_all(:player_id => user.id)
  end


###Created by Samantha Lee on 9/18/2019

###Updated by Samantha Lee on 9/24/2019 to return true or false if piece exists
#allows you to test if a piece exsits at a given location on the board
#returns true if a piece exists, the space is occupied
#returns false if a piece does not exist, the space is empty
def piece_exists?(x,y)
  piece = self.game.pieces.where(x_pos: x, y_pos: y)
  if piece.exists?
    true
  else
    false
  end
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
  #if is_obstructed method is false, meaning there are no pieces in the moving path
  if is_obstructed?(x,y) == false
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
      #if there is no piece to capture, relocate the moving piece to the empty spot
      self.move(x,y)
    end
  else
    puts "You can't move, your piece is obstructed"
  end
end

###Ends Samantha's updates from 9/18/2019

  #private 

###Samantha Lee updated methods from Cooper on 9/18/2019


  #Check that x axis value changes
  #Check that y axis value stays same
  #Check if x ending position is enemy occupied
  def horizontal_block?(x_axis)
    #Check if piece is moving left or right
    #Right
    if x_axis > self.x_pos
      (x_axis + self.x_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos + i + 1, y_pos: self.y_pos).empty?
        #return false, there is no horizontal block and piece can move
        false
      end
    #Left
    else  
      #Will return array
      #Left space check
      (x_axis - self.x_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos - i + 1, y_pos: self.y_pos).empty?
        #return false, there is no horizontal block and piece can move
        false
      end
    end
  end

  #Checks if there is a piece on the vertical path of a moving piece
  def vertical_block?(y_axis)
    #if the y_pos endpoint value is greated than the y vale of the moving piece
   if y_axis > self.y_pos
      #test path moving up for pieces
      (y_axis + self.y_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos, y_pos: self.y_pos + i + 1).empty?
        #return false, there is no vertical block and piece can move
        false
      end
    #if the y_pos endpoint value is less than the y value of the moving piece
    else  
      #Will return array
      #test path moving down for pieces
      (y_axis - self.y_pos).times do |i|
        self.game.pieces.where(x_pos: self.x_pos, y_pos: self.y_pos - i + 1).empty?
        #return false, there is no vertical block and piece can move
        false
      end
    end
  end


  #Similar to find piece method, but this specifically tests for an empty spot
  def open_space?(x_end, y_end)
    #Check if space is open
    self.game.pieces.where(x_pos: x_end, y_pos: y_end).empty?
  end

### End of Samantha's updates on 9/18/2019


### Created by Samantha on 9/22/2019

#test if a move is a valid diagonal move
def diagonal_move?(x_end, y_end)
  #define a method for slope
  slope = (y_end - self.y_pos) / (x_end - self.x_pos)
  #if slope is equal to 1 or -1, true, it is a diagonal move
  if slope == 1 || slope == -1
    true
  #if slope is not equal to 1 or -1, false, it is not a diagonal move
  else
    false
  end
end

#test if a valid diagonal path is obstructed
#if there are pieces on the path, diagonal_block? returns true
#if the path is clear, diagonal_block? returns false
def diagonal_block?(x_end, y_end)

  #if the move is a diagonal valid move
  if diagonal_move?(x_end, y_end) == true
    #test if there are obstruction pieces on diagonal path

    #if the endpoint x,y are both greater than starting x,y
    #NE direction slope
    if x_end > self.x_pos && y_end > self.y_pos
      #determines number of times to iterate
      (x_end - self.x_pos).times do |i|
      #if adding 1 to each x and y pos value returns an empty space
      self.game.pieces.where(x_pos: self.x_pos + i + 1, y_pos: self.y_pos + i + 1).empty?
      false
      end

    #if the endpoint x,y are both less than starting x,y
    #SW direction slope
    elsif x_end < self.x_pos && y_end < self.y_pos
      #determines number of times to iterate
      (self.x_pos - x_end).times do |i|
      #if subtracting 1 from each x and y pos value returns an empty space
      self.game.pieces.where(x_pos: self.x_pos - i - 1, y_pos: self.y_pos - i - 1).empty?
      false
      end

    #if the endpoint x is greater than starting x and endpoint y is less than starting y
    #NW direction slope
    elsif x_end > self.x_pos && y_end < self.y_pos
      #determines number of times to iterate
      (y_end - self.y_pos).times do |i|
      #if adding 1 to x_pos and subtracting 1 to y_pos returns an empty space
      self.game.pieces.where(x_pos: self.x_pos + i + 1, y_pos: self.y_pos - i - 1).empty?
      false
      end

    #if the endpoint x is less than starting x and endpoint y is greater than starting y
    #SE direction slope
    else x_end < self.x_pos && y_end > self.y_pos
      #determines number of times to iterate
      (x_end - self.x_pos).times do |i|
      #if subtracting 1 from x_pos and adding 1 to y_pos returns and empty space
      self.game.pieces.where(x_pos: self.x_pos - i - 1, y_pos: self.y_pos + i + 1).empty?
      false
      end 

  end

    #if diagonal_move? = false
    else
      puts "That is not a diagonal move"
end

end


end
