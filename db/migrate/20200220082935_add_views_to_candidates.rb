class AddViewsToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :views, :integer, default: 0
  end
end
