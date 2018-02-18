class ChangePassageDateToPassageDateTime < ActiveRecord::Migration[5.1]
  def change
    rename_column :passages, :departure_date, :departure_date_time
    rename_column :passages, :arrival_date, :arrival_date_time
  end
end
