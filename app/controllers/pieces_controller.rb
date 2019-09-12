class PiecesController < ApplicationController

	def show
		@piece = Piece.find(params[:id])  #find piece that is selected
		# @piece.update_attributes!(piece_params)  Don't need this part just to show a piece --Matt Arrick 9/12
	end

  def update(x,y)
    @piece.update_attributes(:x_pos => x, :y_pos => y)
    redirect_to game_path
  end
	
	private

	def piece_params

		piece_params = params.require(:piece).permit(:id,  #Removed @ from piece_params and add all attributes to permit
			:piece_type,                                       #Matt Arrick 9/12
			:x_pos,
			:y_pos,
			:game_id,
      :player_id)
	end
end
