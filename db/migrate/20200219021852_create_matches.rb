class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.references :job, foreign_key: true
      t.references :candidate, foreign_key: true
      t.boolean :job_like
      t.boolean :candidate_like
      t.timestamps
    end
  end
end
