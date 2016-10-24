class CreateDataFromFile
  require 'csv'

  ROWS_TO_IGNORE = ["Activities", "Sleep", "Date", nil]

  def initialize(file, user)
    @file = file
    @user = user
  end

  def call
    CSV.foreach(@file) do |row|
      next if ignore_row?(row[0])

      if activity_row?(row)
        create_activity(row)
      elsif sleep_row?(row)
        create_sleep(row)
      end
    end
  end

  private

  def ignore_row?(first_field)
    ROWS_TO_IGNORE.include?(first_field)
  end

  def activity_row?(row)
    row[9] != nil
  end

  def sleep_row?(row)
    row[5] == nil
  end

  def create_activity(row)
    @user.activities.create!(date: Date.parse(row[0]), calories_burned: convert_to_i(row[1]), steps: convert_to_i(row[2]), distance: row[3].to_d, floors: convert_to_i(row[4]), minutes_sedentary: convert_to_i(row[5]), minutes_lightly_active: convert_to_i(row[6]), minutes_fairly_active: convert_to_i(row[7]), minutes_very_active: convert_to_i(row[8]), activity_calories: convert_to_i(row[9]))
  end

  def create_sleep(row)
    @user.sleeps.create!(date: Date.parse(row[0]), minutes_asleep: convert_to_i(row[1]), minutes_awake: convert_to_i(row[2]), number_of_awakenings: convert_to_i(row[3]), time_in_bed: convert_to_i(row[4]))
  end

  def convert_to_i(value)
    value.gsub(/\D/, '').to_i
  end
end
