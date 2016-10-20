class Sleep < ApplicationRecord
  belongs_to :user

  validates :minutes_asleep, :minutes_awake, :number_of_awakenings, :time_in_bed, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
