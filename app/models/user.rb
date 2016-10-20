class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sleeps, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :name, presence: true, length: { in: 2..20 }

  NO_STEPS_MESSAGE = "No steps recorded"

  def lifetime_floors
    activities.sum(&:floors)
  end

  def lifetime_kilometres
    activities.sum(&:distance)
  end

  def lifetime_steps
    activities.sum(&:steps)
  end

  def highest_steps
    activity = highest_step_activity

    activity ? activity.steps : NO_STEPS_MESSAGE
  end

  def highest_step_date
    activity = highest_step_activity

    activity ? activity.date : NO_STEPS_MESSAGE
  end

  private

  def highest_step_activity
    activities.max_by{ |activity| activity.steps }
  end
end
