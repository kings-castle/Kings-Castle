class Queen < Piece
  ### Created by Matt Arrick 9/26/19
  def valid_move?(x, y)
    # Queen can move any number of non obstructed horizontal, vertical, or diagonal spaces
    # Check for obstructions and then test each directional movement
    if is_obstructed(x, y) == true ||
        diagonal_block(x, y) == true ||
        x_pos != x ||
        y_pos != y ||
        (x_pos - x).abs != (y_pos - y).abs
      false
    else
      true
    end
  end
end