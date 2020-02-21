class AddAvatarUrlColumnToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :avatar_url, :string
  end
end
