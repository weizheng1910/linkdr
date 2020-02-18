class Companies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
    t.string :name
    t.string :industry
    t.string :size
    t.references :user_company
    t.timestamps
    end
  end
end
