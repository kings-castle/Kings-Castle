class Bishop < Piece
  ###Created by Matt Arrick 9/27/19
  def valid_move?(x, y)
    # Bishop can move any number of non obstructed diagonal spaces
    # Using the .abs method on each equation returns the absolute value which
      # will simplfy the logic for forward or backward movements. Always subtract
      # the starting position (x_pos, y_pos) from the ending position (x, y). Even if starting position
      # is less than ending position, .abs will still return a positive number eliminating the 
      # need for testing positive or negative movements

    # Check for obstructions and then test move logic
      # If "is_obstructed" OR "diagonal_block" is "true" OR
        # not a diagonal move ((x_pos - x) does not equal (y_pos - y))
        # then return false
    if is_obstructed?(x, y) == true ||              # is_obstructed? test
        diagonal_block?(x, y) == true ||            # diagonal_block? test
        (x_pos - x).abs != (y_pos - y).abs          # diagonal test
      false
    else
      true
    end
  end
end