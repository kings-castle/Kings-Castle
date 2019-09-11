class PiecesController < ApplicationController

	def show
		@piece = Piece.find(params[:id])  #find piece that is selected
		@piece.update_attributes!(piece_params)
	end

  def update(x,y)
    @piece.update_attributes(:x_pos => x, :y_pos => y)
    redirect_to game_path
  end
	
	private

	def piece_params

		@piece_params = params.require(:piece).permit(
			:piece_type,
			:x_pos,
			:y_pos,
			:game_id)
	end
end
