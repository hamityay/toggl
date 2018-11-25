class CreateTimers < ActiveRecord::Migration[5.2]
  def change
    create_table :timers do |t|
      t.text :info
      t.datetime :start
      t.datetime :finish
      t.references :type, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
