class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sleeps, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :name, presence: true, length: { in: 2..20 }

  NO_FLOORS_MESSAGE = "No floors recorded"
  NO_KM_MESSAGE = "No kilometres recorded"
  NO_STEPS_MESSAGE = "No steps recorded"
  NO_ACTIVITY_MESSAGE = "No activity recorded"
  NO_CALORIES_MESSAGE = "No calories recorded"

  def lifetime_floors
    activities.sum(&:floors)
  end

  def lifetime_kilometres
    activities.sum(&:distance)
  end

  def lifetime_steps
    activities.sum(&:steps)
  end

  def lifetime_calories_burned
    activities.sum(&:calories_burned)
  end

  def lifetime_minutes_asleep
    sleeps.sum(&:minutes_asleep)
  end

  def lifetime_minutes_awake
    sleeps.sum(&:minutes_awake)
  end

  def lifetime_awakenings
    sleeps.sum(&:number_of_awakenings)
  end

  def lifetime_time_in_bed
    sleeps.sum(&:time_in_bed)
  end

  def calculate_average(sum_of_values, total_number)
    if sum_of_values > 0
      (sum_of_values / total_number).round(2)
    else
      sum_of_values
    end
  end

  def average_calories_burned
    calculate_average(lifetime_calories_burned, activities.count)
  end

  def average_floors
    calculate_average(lifetime_floors, activities.count)
  end

  def average_kilometres
    calculate_average(lifetime_kilometres, activities.count)
  end

  def average_minutes_asleep
    calculate_average(lifetime_minutes_asleep, sleeps.count)
  end

  def average_minutes_awake
    calculate_average(lifetime_minutes_awake, sleeps.count)
  end

  def average_awakenings
    calculate_average(lifetime_awakenings, sleeps.count)
  end

  def average_time_in_bed
    calculate_average(lifetime_time_in_bed, sleeps.count)
  end

  def average_steps
    calculate_average(lifetime_steps, activities.count)
  end

  def highest_floors
    activity = highest_floor_activity

    activity ? activity.floors : 0
  end

  def highest_floor_date
    activity = highest_floor_activity

    activity ? activity.date : NO_FLOORS_MESSAGE
  end

  def highest_kilometres
    activity = highest_kilometre_activity

    activity ? activity.distance : 0
  end

  def highest_kilometre_date
    activity = highest_kilometre_activity

    activity ? activity.date : NO_KM_MESSAGE
  end

  def highest_steps
    activity = highest_step_activity

    activity ? activity.steps : 0
  end

  def highest_step_date
    activity = highest_step_activity

    activity ? activity.date : NO_STEPS_MESSAGE
  end

  def highest_calories_burned
    activity = highest_calories_burned_activity

    activity ? activity.calories_burned : 0
  end

  def highest_calories_burned_date
    activity = highest_calories_burned_activity

    activity ? activity.date : NO_CALORIES_MESSAGE
  end

  def lowest_floors
    activity = lowest_floor_activity

    activity ? activity.floors : 0
  end

  def lowest_floor_date
    activity = lowest_floor_activity

    activity ? activity.date : NO_FLOORS_MESSAGE
  end

  def lowest_steps
    activity = lowest_step_activity

    activity ? activity.steps : 0
  end

  def lowest_step_date
    activity = lowest_step_activity

    activity ? activity.date : NO_STEPS_MESSAGE
  end

  def lowest_kilometres
    activity = lowest_kilometre_activity

    activity ? activity.distance : 0
  end

  def lowest_kilometre_date
    activity = lowest_kilometre_activity

    activity ? activity.date : NO_KM_MESSAGE
  end

  def lowest_calories_burned
    activity = lowest_calories_burned_activity

    activity ? activity.calories_burned : 0
  end

  def lowest_calories_burned_date
    activity = lowest_calories_burned_activity

    activity ? activity.date : NO_CALORIES_MESSAGE
  end

  def highest_very_active_minutes
    very_active = highest_very_active_activity

    very_active ? very_active.minutes_very_active : 0
  end

  def highest_very_active_date
    very_active = highest_very_active_activity

    very_active ? very_active.date : NO_ACTIVITY_MESSAGE
  end

  def most_active_day
    activity = highest_active_activity

    activity ? activity.date : NO_ACTIVITY_MESSAGE
  end

  def least_active_day
    activity = highest_sedentary_activity

    activity ? activity.date : NO_ACTIVITY_MESSAGE
  end

  private

  def highest_floor_activity
    activities.max_by { |activity| activity.floors }
  end

  def highest_kilometre_activity
    activities.max_by { |activity| activity.distance }
  end

  def highest_step_activity
    activities.max_by { |activity| activity.steps }
  end

  def highest_calories_burned_activity
    activities.max_by { |activity| activity.calories_burned }
  end

  def lowest_floor_activity
    activities.min_by { |activity| activity.floors }
  end

  def lowest_step_activity
    activities.min_by { |activity| activity.steps }
  end

  def lowest_kilometre_activity
    activities.min_by { |activity| activity.distance }
  end

  def lowest_calories_burned_activity
    activities.min_by { |activity| activity.calories_burned }
  end

  def highest_very_active_activity
    activities.max_by { |activity| activity.minutes_very_active }
  end

  def highest_active_activity
    activities.max_by { |activity| activity.total_active_minutes }
  end

  def highest_sedentary_activity
    activities.max_by { |activity| activity.minutes_sedentary }
  end
end
