class Knight < Piece

  ### Created by Samantha Lee 9/29/2019

  #Knight can move to the following endpoints
    #x+1, y+2
    #x+1, y-2
    #x+2, y+1
    #x+2, y-1
    #x-1, y+2
    #x-1, y-2
    #x-2, y-1
    #x-2, y+1

    #check to see if the passed endpoint is equal to any of the possible endpoint locations

  def valid_move?(x, y)
    if  
      x = self.x_pos + 1 && y = self.y_pos + 2 ||
      x = self.x_pos + 1 && y = self.y_pos - 2 ||
      x = self.x_pos + 2 && y = self.y_pos + 1 ||
      x = self.x_pos + 2 && y = self.y_pos - 1 ||
      x = self.x_pos - 1 && y = self.y_pos + 2 ||
      x = self.x_pos - 1 && y = self.y_pos - 2 ||
      x = self.x_pos - 2 && y = self.y_pos - 1 ||
      x = self.x_pos - 2 && y = self.y_pos + 1

        true
      else
        false
    end
  end


end