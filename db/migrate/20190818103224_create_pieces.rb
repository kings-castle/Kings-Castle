class CreatePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :pieces do |t|
      t.string :piece_type
      t.integer :x_pos
      t.integer :y_pos
      t.integer :game_id
      t.integer :player_id
      t.timestamps
    end
  end
end
