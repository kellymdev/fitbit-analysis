require 'rails_helper'

RSpec.describe GraphsController, type: :controller do
  let(:user) { User.create!(name: "Bob", email: "test@example.com", password: "test12") }

  before do
    sign_in user

    user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 20, minutes_fairly_active: 15, minutes_very_active: 9, activity_calories: 354)
    user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1453, steps: 9842, distance: "7.51".to_d, floors: 5, minutes_sedentary: 524, minutes_lightly_active: 9, minutes_fairly_active: 40, minutes_very_active: 1, activity_calories: 354)
  end

  describe '#floor_data' do
    before { get :floor_data, params: { format: :json } }

    it 'provides floor data from the users activities' do
      expected_data = user.activities.order(:date).as_json(only: [:date, :floors]).to_json

      expect(response.body).to eq(expected_data)
    end
  end

  describe '#step_data' do
    before { get :step_data, params: { format: :json } }

    it 'provides step data from the users activities' do
      expected_data = user.activities.order(:date).as_json(only: [:date, :steps]).to_json

      expect(response.body).to eq(expected_data)
    end
  end

  describe '#km_data' do
    before { get :km_data, params: { format: :json } }

    it 'provides distance data from the users activities' do
      expected_data = user.activities.order(:date).as_json(only: [:date, :distance]).to_json

      expect(response.body).to eq(expected_data)
    end
  end

  describe '#calorie_data' do
    before { get :calorie_data, params: { format: :json } }

    it 'provides calorie data from the users activities' do
      expected_data = user.activities.order(:date).as_json(only: [:date, :calories_burned]).to_json

      expect(response.body).to eq(expected_data)
    end
  end

  describe '#activity_data' do
    before { get :activity_data, params: { format: :json } }

    it 'provides activity data from the users activities' do
      expected_data = user.activities.order(:date).as_json(only: [:date, :minutes_sedentary, :minutes_lightly_active, :minutes_fairly_active, :minutes_very_active]).to_json

      expect(response.body).to eq(expected_data)
    end
  end

  describe '#sleep_data' do
    before do
      user.sleeps.create!(date: Date.parse("01-09-2016"), minutes_asleep: 417, minutes_awake: 84, number_of_awakenings: 1, time_in_bed: 510)
      user.sleeps.create!(date: Date.parse("02-09-2016"), minutes_asleep: 389, minutes_awake: 93, number_of_awakenings: 3, time_in_bed: 482)

      get :sleep_data, params: { format: :json }
    end

    it 'provides sleep data from the users sleeps' do
      expected_data = user.sleeps.order(:date).as_json(only: [:date, :minutes_asleep, :minutes_awake]).to_json

      expect(response.body).to eq(expected_data)
    end
  end
end
