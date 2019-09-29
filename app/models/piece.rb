class Piece < ApplicationRecord
  # attr_accessor :color, :postion

  #sets associations with pieces to game and player
  belongs_to :game
  belongs_to :player, optional: true #UPDATE Matt Arrick 9/18/19 
                                        # Added 'optional: true' to allow nil player_id for black pieces upon game creation

  self.inheritance_column = :piece_type

  #Define is_obstructed? method
  ### Updated by Samantha 9/25/2019
  def is_obstructed?(x,y)
    #calls horizontal and vertical block methods with the endpoint argument
    #if either horizontal block or vertical block returns false
    if self.horizontal_block?(x,y) == false || self.vertical_block?(x,y) == false || self.diagonal_block?(x,y) == false
      #return false, no obstruction
      #piece can move/capture
      false
    else
      #return true, the path is_obstructed and the piece cannot move
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

#tests for a piece at the given y location on the board
def y_location?(y)
  piece = self.game.pieces.where(y_pos: y)
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
  if is_obstructed?(x,y) == false && valid_move?(x,y) == true
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

###Samantha Lee proposed new horizonal and vertical block methods on 9/25/2019

  #test if there is a horizontal block on a moving piece
  #returns true if there is a block
  #returns false if there is a block
  #is_obstructed should call this method and check for false instances
  #each iteration only checks the spaces between the start and end point
  def horizontal_block?(x,y)
    #test for right horizontal movement
    if self.x_pos < x
      (self.x_pos+1...x).each do |x|
        #if a piece at any spot on the path exists, return true
        return true if game.pieces.find_by_x_pos_and_y_pos(x,y).present?
      end
        #if there are no pieces on the path, return false
        return false
    end

    #test for left horizontal movement
    if self.x_pos > x
      (x+1...self.x_pos).each do |x|
        #if a piece at any spot on the path exists, return true
        return true if game.pieces.find_by_x_pos_and_y_pos(x,y).present?
      end
        #if there are no pieces on the path, return false
        return false
    end
  end

  #test if there is a vertical block on a moving piece
  #returns true if there is a block
  #returns false if there is a block
  #is_obstructed should call this method and check for false instances
  #each iteration only checks the spaces between the start and end point
  def vertical_block?(x,y)
    #test for upward vertical movement
    if self.y_pos < y
      (self.y_pos+1...y).each do |y|
        #if a piece at any spot on the path exists, return true
        return true if game.pieces.find_by_x_pos_and_y_pos(x,y).present?
      end
        #if there are no pieces on the path, return false
        return false
    end
    
    #test for downward vertical movement    
    if self.y_pos > y
      (y+1...self.y_pos).each do |y|
        #if a piece at any spot on the path exists, return true
        return true if game.pieces.find_by_x_pos_and_y_pos(x,y).present?
      end
        #if there are no pieces on the path, return false
        return false
    end

  end

  #Similar to find piece method, but this specifically tests for an empty spot
  def open_space?(x_end, y_end)
    #Check if space is open
    self.game.pieces.where(x_pos: x_end, y_pos: y_end).empty?
  end


### Created by Samantha on 9/22/2019
### Updated by Samantha on 9/25/2019

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


### Created by Samantha on 9/29/2019
#checks for obstruction on diagonal moving path
#does not check for obstruction of endpoint
def diagonal_block?(x,y)
  #if the movement is a valid diagonal move
  if diagonal_move?(x, y) == true

  #if the endpoint x,y are both greater than starting x,y
  #NE direction slope
  if x > self.x_pos && y > self.y_pos
    y_pos = (self.y_pos + 1)
    ((self.x_pos + 1)...x).each do |x|
      if game.pieces.find_by_x_pos_and_y_pos(x,y_pos).present? == false
        y_pos += 1
      else
        return true
      end
    end
    return false

  #if the endpoint x is greater than starting x and endpoint y is less than starting y
  #NW direction slope
  elsif x > self.x_pos && y < self.y_pos
    y_pos = (self.y_pos - 1)
      ((self.x_pos + 1)...x).each do |x|
        if game.pieces.find_by_x_pos_and_y_pos(x,y_pos).present? == false
          y_pos -= 1
        else
          return true
        end
      end
      return false

  #if the endpoint x,y are both less than starting x,y
  #SW direction slope
  #not loading pieces to check
  elsif x < self.x_pos && y < self.y_pos
    y_pos = (self.y_pos - 1)
      (x + 1...(self.x_pos)).each do |x|
        if game.pieces.find_by_x_pos_and_y_pos(x,y_pos).present? == false
          y_pos -= 1
        else
          return true
        end
      end
      return false

  #if the endpoint x is less than starting x and endpoint y is greater than starting y
  #SE direction slope
  else x < self.x_pos && y > self.y_pos
    y_pos = (self.y_pos + 1)
      (x + 1 ...(self.x_pos)).each do |x|
        if game.pieces.find_by_x_pos_and_y_pos(x,y_pos).present? == false
          y_pos += 1
        else
          return true
        end
      end
      return false
  end

  end

  if diagonal_move?(x, y) == false
    puts "that is not a diagonal move"
  end
end
  

end
