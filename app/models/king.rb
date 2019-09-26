class King < Piece  
  ### Created by Matt Arrick 9/25/19
  def valid_move?(x,y)
    # King can only move one space at a time
    # Using the .abs method on each equation returns the absolute value which
      # will simplfy the logic for forward or backward movements. Always subtract
      # the starting position (x_pos, y_pos) from the ending position (x, y). Even if starting position
      # is less than ending position, .abs will still return a positive number eliminating the 
      # need for testing positive or negative movements

    # Test for horizontal, vertical or diagonal movement
    # Check for obstructions then test move logic 
      # If "is_obstructed?" OR "diagonal_block?" is "true" OR
        # horizontal move OR vertical move are greater than 1 space OR
        # diagonal move ((x - x) + (y - y)) is greater than 2
        # then return false
    if is_obstructed?(x, y) == true ||             # is_obstructed? test
        diagonal_block?(x,y) == true ||            # diagonal_block test
        (x_pos - x).abs > 1 ||                     # Horizontal movement test
        (y_pos - y).abs > 1 ||                     # Vertical movement test
        (x_pos - x).abs + (y_pos - y).abs > 2      # Diagonal movement test
       # If any of the above are true, return false because move is invalid
      false
    else
      true
    end
    # We will need to add some logic for check? when we write that method
  end
end