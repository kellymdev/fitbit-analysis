require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { "Bob" }
  let(:user) { User.new(name: name, email: "test@example.com", password: "test12") }

  describe 'associations' do
    it { is_expected.to have_many(:sleeps) }

    it { is_expected.to have_many(:activities) }
  end

  describe 'validations' do
    describe 'name' do
      context 'with a 2 character name' do
        let(:name) { "Hi" }

        it 'is valid' do
          expect(user).to be_valid
        end
      end

      context 'with a 20 character name' do
        let(:name) { "abcdefghijklmnopqrst" }

        it 'is valid' do
          expect(user).to be_valid
        end
      end

      context 'with a single character name' do
        let(:name) { "A" }

        it 'is not valid' do
          expect(user).not_to be_valid
        end
      end

      context 'with a 21 character name' do
        let(:name) { "abcdefghijklmnopqrstu" }

        it 'is not valid' do
          expect(user).not_to be_valid
        end
      end
    end
  end

  describe '#lifetime_floors' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'equals 0' do
        expect(user.lifetime_floors).to eq(0)
      end
    end

    context 'when no floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 0, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'equals 0' do
        expect(user.lifetime_floors).to eq(0)
      end
    end

    context 'when floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'equals the total number of floors climbed by the user' do
        expect(user.lifetime_floors).to eq(30)
      end
    end
  end

  describe '#lifetime_kilometres' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'equals 0' do
        expect(user.lifetime_kilometres).to eq(0)
      end
    end

    context 'when no kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "0.0".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'equals 0' do
        expect(user.lifetime_kilometres).to eq(0)
      end
    end

    context 'when kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'equals the total number of kilometres walked' do
        expect(user.lifetime_kilometres).to eq('5.25'.to_d)
      end
    end
  end

  describe '#lifetime_steps' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'equals 0' do
        expect(user.lifetime_steps).to eq(0)
      end
    end

    context 'when no steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 0, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'equals 0' do
        expect(user.lifetime_steps).to eq(0)
      end
    end

    context 'when steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'equals the total number of steps walked' do
        expect(user.lifetime_steps).to eq(7942)
      end
    end
  end

  describe '#highest_steps' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns a no steps recorded message' do
        expect(user.highest_steps).to eq("No steps recorded")
      end
    end

    context 'when no steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 0, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.highest_steps).to eq(0)
      end
    end

    context 'when steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the highest numbers of steps' do
        expect(user.highest_steps).to eq(5483)
      end
    end
  end

  describe '#highest_step_date' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns a no steps recorded message' do
        expect(user.highest_step_date).to eq("No steps recorded")
      end
    end

    context 'when no steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 0, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.highest_step_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the date that the highest number of steps was walked' do
        expect(user.highest_step_date).to eq(Date.parse("02-10-2016"))
      end
    end

    context 'when two days have the same number of steps' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 5483, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the first date' do
        expect(user.highest_step_date).to eq(Date.parse("01-10-2016"))
      end
    end
  end
end
