class PiecesController < ApplicationController

  def create
    @piece = Piece.create(piece_params)
  end

  def show
    @piece = Piece.find(params[:id])  #find piece that is selected
    @piece.update_attributes!(piece_params)
  end

  private

  def piece_params
    params.reqire(:piece).permit(:piece_type, :x_pos, :y_pos, :game_id, :player_id)
  end

end
