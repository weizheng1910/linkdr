class AddMatchToRooms < ActiveRecord::Migration[5.2]
  def change
    add_reference :rooms, :match, foreign_key: true
    
  end
end
