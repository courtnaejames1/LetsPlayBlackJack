class ChangeDefault < ActiveRecord::Migration[8.1]
  def change
    change_column_default :games, :status, "in_progress"
  end
end
