class GraphsController < ApplicationController
  before_action :authenticate_user!

  def floor_data
    respond_to do |format|
      format.json {
        render json: current_user.activities.order(:date).as_json(only: [:date, :floors])
      }
    end
  end

  def step_data
    respond_to do |format|
      format.json {
        render json: current_user.activities.order(:date).as_json(only: [:date, :steps])
      }
    end
  end

  def km_data
    respond_to do |format|
      format.json {
        render json: current_user.activities.order(:date).as_json(only: [:date, :distance])
      }
    end
  end

  def calorie_data
    respond_to do |format|
      format.json {
        render json: current_user.activities.order(:date).as_json(only: [:date, :calories_burned])
      }
    end
  end

  def activity_data
    respond_to do |format|
      format.json {
        render json: current_user.activities.order(:date).as_json(only: [:date, :minutes_sedentary, :minutes_lightly_active, :minutes_fairly_active, :minutes_very_active])
      }
    end
  end

  def sleep_data
    respond_to do |format|
      format.json {
        render json: current_user.sleeps.order(:date).as_json(only: [:date, :minutes_asleep, :minutes_awake])
      }
    end
  end
end
