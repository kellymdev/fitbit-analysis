class GraphsController < ApplicationController
  def floor_data
    respond_to do |format|
      format.json {
        render json: current_user.activities.as_json(only: [:date, :floors])
      }
    end
  end

  def step_data
    respond_to do |format|
      format.json {
        render json: current_user.activities.as_json(only: [:date, :steps])
      }
    end
  end

  def km_data
    respond_to do |format|
      format.json {
        render json: current_user.activities.as_json(only: [:date, :distance])
      }
    end
  end

  def calorie_data
    respond_to do |format|
      format.json {
        render json: current_user.activities.as_json(only: [:date, :calories_burned])
      }
    end
  end
end
