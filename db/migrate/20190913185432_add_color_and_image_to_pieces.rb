class AddColorAndImageToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :color, :boolean
    add_column :pieces, :image, :string
  end
end
