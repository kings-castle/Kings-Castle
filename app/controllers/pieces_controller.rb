class PiecesController < ApplicationController

  def create
    @piece = Piece.create(piece_params)
  end

  def show
    @piece = Piece.find_by_id(params[:id])
  end

  def update(x, y)
    @piece = Piece.find_by_id(params[:id])
    @piece.update_attributes(:x_pos => x, :y_pos => y)
  end

  # def find_by_coords(x, y, g_id)
  #   @piece = Piece.find_by_x_pos_and_y_pos_and_game_id(x, y, g_id)
  # end

  private

  def piece_params
    params.reqire(:piece).permit(:piece_type, :x_pos, :y_pos, :game_id, :player_id)
  end
end
