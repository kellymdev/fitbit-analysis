class GraphsController < ApplicationController
  def floor_data
    respond_to do |format|
      format.json {
        render json: current_user.activities.as_json(only: [:date, :floors])
      }
    end
  end
end