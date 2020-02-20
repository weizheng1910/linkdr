class AddViewsToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :views, :integer, default: 0
  end
end
