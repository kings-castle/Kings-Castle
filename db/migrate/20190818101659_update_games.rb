class UpdateGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :game_id, :integer
    add_column :games, :white_player_id, :integer
    add_column :games, :black_player_id, :integer
  end
end
