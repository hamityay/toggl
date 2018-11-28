class AddDurationToTimers < ActiveRecord::Migration[5.2]
  def change
    add_column :timers, :duration, :float
  end
end
