class AddDefaultStatusToTask < ActiveRecord::Migration[5.0]
  def change
    change_column_default :tasks, :status, 1
  end
end
