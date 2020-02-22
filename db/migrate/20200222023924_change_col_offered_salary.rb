class ChangeColOfferedSalary < ActiveRecord::Migration[5.2]
  def change
    change_column :jobs, :offered_salary, :integer, using: "offered_salary::integer"
  end
end

