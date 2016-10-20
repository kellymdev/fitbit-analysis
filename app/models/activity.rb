class Activity < ApplicationRecord
  belongs_to :user

  validates :calories_burned, :steps, :floors, :minutes_sedentary, :minutes_lightly_active, :minutes_fairly_active, :minutes_very_active, :activity_calories, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :distance, numericality: { greater_than_or_equal_to: 0.0 }
end
