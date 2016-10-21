require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    describe 'calories_burned' do
      it 'is valid with calories of 0' do
        expect(Activity.new(calories_burned: 0)).to have(0).errors_on(:calories_burned)
      end

      it 'is valid with a positive calories value' do
        expect(Activity.new(calories_burned: 5)).to have(0).errors_on(:calories_burned)
      end

      it 'has errors when calories_burned is a negative value' do
        expect(Activity.new(calories_burned: -1)).to have(1).error_on(:calories_burned)
      end
    end

    describe 'steps' do
      it 'is valid with steps of 0' do
        expect(Activity.new(steps: 0)).to have(0).errors_on(:steps)
      end

      it 'is valid with a positive steps value' do
        expect(Activity.new(steps: 10)).to have(0).errors_on(:steps)
      end

      it 'has errors when steps is a negative value' do
        expect(Activity.new(steps: -1)).to have(1).error_on(:steps)
      end
    end

    describe 'floors' do
      it 'is valid with floors of 0' do
        expect(Activity.new(floors: 0)).to have(0).errors_on(:floors)
      end

      it 'is valid with a positive floors value' do
        expect(Activity.new(floors: 7)).to have(0).errors_on(:floors)
      end

      it 'has errors when floors is a negative value' do
        expect(Activity.new(floors: -1)).to have(1).error_on(:floors)
      end
    end

    describe 'minutes_sedentary' do
      it 'is valid with minutes of 0' do
        expect(Activity.new(minutes_sedentary: 0)).to have(0).errors_on(:minutes_sedentary)
      end

      it 'is valid with a positive minutes value' do
        expect(Activity.new(minutes_sedentary: 3)).to have(0).errors_on(:minutes_sedentary)
      end

      it 'has errors when minutes is a negative value' do
        expect(Activity.new(minutes_sedentary: -1)).to have(1).error_on(:minutes_sedentary)
      end
    end

    describe 'minutes_lightly_active' do
      it 'is valid with minutes of 0' do
        expect(Activity.new(minutes_lightly_active: 0)).to have(0).errors_on(:minutes_lightly_active)
      end

      it 'is valid with a positive minutes value' do
        expect(Activity.new(minutes_lightly_active: 2)).to have(0).errors_on(:minutes_lightly_active)
      end

      it 'has errors when minutes is a negative value' do
        expect(Activity.new(minutes_lightly_active: -1)).to have(1).error_on(:minutes_lightly_active)
      end
    end

    describe 'minutes_fairly_active' do
      it 'is valid with minutes of 0' do
        expect(Activity.new(minutes_fairly_active: 0)).to have(0).errors_on(:minutes_fairly_active)
      end

      it 'is valid with a positive minutes value' do
        expect(Activity.new(minutes_fairly_active: 3)).to have(0).errors_on(:minutes_fairly_active)
      end

      it 'has errors when minutes is a negative value' do
        expect(Activity.new(minutes_fairly_active: -1)).to have(1).error_on(:minutes_fairly_active)
      end
    end

    describe 'minutes_very_active' do
      it 'is valid with minutes of 0' do
        expect(Activity.new(minutes_very_active: 0)).to have(0).errors_on(:minutes_very_active)
      end

      it 'is valid with a positive minutes value' do
        expect(Activity.new(minutes_very_active: 2)).to have(0).errors_on(:minutes_very_active)
      end

      it 'has errors when minutes is a negative value' do
        expect(Activity.new(minutes_very_active: -1)).to have(1).error_on(:minutes_very_active)
      end
    end

    describe 'activity_calories' do
      it 'is valid with activity calories of 0' do
        expect(Activity.new(activity_calories: 0)).to have(0).errors_on(:activity_calories)
      end

      it 'is valid with a positive activity calories value' do
        expect(Activity.new(activity_calories: 4)).to have(0).errors_on(:activity_calories)
      end

      it 'has errors when activity calories is a negative value' do
        expect(Activity.new(activity_calories: -1)).to have(1).error_on(:activity_calories)
      end
    end

    describe 'distance' do
      it 'is valid with a distance of 0.0' do
        expect(Activity.new(distance: 0.0)).to have(0).errors_on(:distance)
      end

      it 'is valid with a positive distance value' do
        expect(Activity.new(distance: 1.3)).to have(0).errors_on(:distance)
      end

      it 'has errors when distance is a negative value' do
        expect(Activity.new(distance: -0.1)).to have(1).error_on(:distance)
      end
    end
  end

  describe '#total_active_minutes' do
    let(:lightly_active) { 0 }
    let(:fairly_active) { 0 }
    let(:very_active) { 0 }
    let(:activity) { Activity.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: lightly_active, minutes_fairly_active: fairly_active, minutes_very_active: very_active, activity_calories: 354) }

    context 'when there are no active minutes' do
      it 'returns 0' do
        expect(activity.total_active_minutes).to eq(0)
      end
    end

    context 'when there are active minutes in some categories' do
      let(:lightly_active) { 25 }
      let(:fairly_active) { 5 }

      it 'returns the sum across the categories' do
        expect(activity.total_active_minutes).to eq(30)
      end
    end

    context 'when there are active minutes across all categories' do
      let(:lightly_active) { 45 }
      let(:fairly_active) { 10 }
      let(:very_active) { 7 }

      it 'returns the sum across all the categories' do
        expect(activity.total_active_minutes).to eq(62)
      end
    end
  end
end
