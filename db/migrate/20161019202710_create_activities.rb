class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.date :date
      t.integer :calories_burned
      t.integer :steps
      t.decimal :distance
      t.integer :floors
      t.integer :minutes_sedentary
      t.integer :minutes_lightly_active
      t.integer :minutes_fairly_active
      t.integer :minutes_very_active
      t.integer :activity_calories
      t.timestamps
    end
  end
end
