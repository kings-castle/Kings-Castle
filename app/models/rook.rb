class Rook < Piece
  ###Createed by Matt Arrick 9/27/19
  def valid_move?(x, y)
    # Rook can move any number of non obstructed horizontal, or vertical spaces

    # Check for obstructions and then test move logic
      # If "is_obstructed" OR "diagonal_block" is "true" OR
        # horizontal ending point (x) does not equal horizontal starting point (x_pos) OR
        # vertical ending point (y) does not equal vertical starting point (y_pos) OR
        # not a diagonal move ((x_pos - x) does not equal (y_pos - y))
        # then return false
    if is_obstructed?(x, y) == true ||              # is_obstructed? test
        diagonal_block?(x, y) == true ||            # diagonal_block? test
        x_pos != x ||                               # horizontal test
        y_pos != y                                  # vertical test
      false
    else
      true
    end
  end

end