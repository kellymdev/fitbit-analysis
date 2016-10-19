class CreateSleeps < ActiveRecord::Migration[5.0]
  def change
    create_table :sleeps do |t|
      t.date :date
      t.integer :minutes_asleep
      t.integer :minutes_awake
      t.integer :number_of_awakenings
      t.integer :time_in_bed
      t.timestamps
    end
  end
end
