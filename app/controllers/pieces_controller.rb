class PiecesController < ApplicationController

	def show
		
	end
	

	def update
		@piece = Piece.find(params[:id])
	end

	private

	def piece_params
		@piece_params = params.require(:piece).permit(
			:x_position,
			:y_position,
			:type)
	end

end
