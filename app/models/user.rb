class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sleeps, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :name, presence: true, length: { in: 2..20 }

  def lifetime_floors
    activities.sum(&:floors)
  end

  def lifetime_kilometres
    activities.sum(&:distance)
  end

  def lifetime_steps
    activities.sum(&:steps)
  end
end
