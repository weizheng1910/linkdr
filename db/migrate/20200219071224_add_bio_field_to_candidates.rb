class AddBioFieldToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :bio, :text
  end
end
