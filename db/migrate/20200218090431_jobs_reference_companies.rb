class JobsReferenceCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :offered_salary, :string
    add_column :jobs, :country, :string
    change_table :jobs do |t|
      t.references :company
    end
  end
end
