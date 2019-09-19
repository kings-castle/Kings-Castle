class Piece < ApplicationRecord
  # attr_accessor :color, :postion


  belongs_to :game
  belongs_to :player, optional: true #:user

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

  def selected?(piece_id)
    self.id
  end


  # def find_by_coords(x, y, g_id)
  #   @piece = Piece.find_by_x_pos_and_y_pos_and_game_id(x, y, g_id)
  # end

  #update the black_player_id to the current_user id
  #this method is called in the games#update action
  def self.assign_player(user)
    where(black_player_id: nil).update_all(black_player_id: user.id)
  end
  

end

