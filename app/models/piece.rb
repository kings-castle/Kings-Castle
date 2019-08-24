class Piece < ApplicationRecord
  attr_accessor :color, :postion

  belongs_to :games
  belongs_to :players

  self.inheritance_column = :piece_type

  def self.piece_types
    %w(Pawn Rook Knight Bishop Queen King)
  end

end
