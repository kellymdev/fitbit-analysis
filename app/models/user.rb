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

  def lifetime_floors
    activities.sum(&:floors)
  end

  def lifetime_kilometres
    activities.sum(&:distance)
  end

  def lifetime_steps
    activities.sum(&:steps)
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

  def highest_very_active_minutes
    very_active = highest_very_active_activity

    very_active ? very_active.minutes_very_active : 0
  end

  def highest_very_active_date
    very_active = highest_very_active_activity

    very_active ? very_active.date : NO_ACTIVITY_MESSAGE
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

  def lowest_floor_activity
    activities.min_by { |activity| activity.floors }
  end

  def lowest_step_activity
    activities.min_by { |activity| activity.steps }
  end

  def lowest_kilometre_activity
    activities.min_by { |activity| activity.distance }
  end

  def highest_very_active_activity
    activities.max_by { |activity| activity.minutes_very_active }
  end
end
