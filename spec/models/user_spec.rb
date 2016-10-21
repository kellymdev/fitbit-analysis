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

  describe '#lifetime_calories_burned' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'equals 0' do
        expect(user.lifetime_calories_burned).to eq(0)
      end
    end

    context 'when no calories have been burned' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 0, steps: 0, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'equals 0' do
        expect(user.lifetime_calories_burned).to eq(0)
      end
    end

    context 'when calories have been burned' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'equals the total number of calories burned' do
        expect(user.lifetime_calories_burned).to eq(2891)
      end
    end
  end

  describe '#average_calories_burned' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.average_calories_burned).to eq(0)
      end
    end

    context 'when no calories have been burned' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 0, steps: 0, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.average_calories_burned).to eq(0)
      end
    end

    context 'when calories have been burned' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the average calories burned' do
        expect(user.average_calories_burned).to eq(1445)
      end
    end
  end

  describe '#average_floors' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.average_floors).to eq(0)
      end
    end

    context 'when no floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2340, distance: "1.63".to_d, floors: 0, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.average_floors).to eq(0)
      end
    end

    context 'when floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the average of the floors climbed' do
        expect(user.average_floors).to eq(15)
      end
    end
  end

  describe '#average_kilometres' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.average_kilometres).to eq(0)
      end
    end

    context 'when no kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "0.0".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.average_kilometres).to eq(0)
      end
    end

    context 'when kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the average kilometres walked per day' do
        expect(user.average_kilometres).to eq(2.63)
      end
    end
  end

  describe '#average_steps' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.average_steps).to eq(0)
      end
    end

    context 'when no steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 0, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.average_steps).to eq(0)
      end
    end

    context 'when steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the average steps per day' do
        expect(user.average_steps).to eq(3971)
      end
    end
  end

  describe '#highest_floors' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.highest_floors).to eq(0)
      end
    end

    context 'when no floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2340, distance: "1.63".to_d, floors: 0, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.highest_floors).to eq(0)
      end
    end

    context 'when floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the highest number of floors climbed in a day' do
        expect(user.highest_floors).to eq(17)
      end
    end
  end

  describe '#highest_floor_date' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns a no floors climbed message' do
        expect(user.highest_floor_date).to eq("No floors recorded")
      end
    end

    context 'when no floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2340, distance: "1.63".to_d, floors: 0, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.highest_floor_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the date that the highest number of floors was climbed' do
        expect(user.highest_floor_date).to eq(Date.parse("02-10-2016"))
      end
    end

    context 'when two dates have the same number of floors climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 17, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the first date' do
        expect(user.highest_floor_date).to eq(Date.parse("01-10-2016"))
      end
    end
  end

  describe '#highest_kilometres' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.highest_kilometres).to eq(0)
      end
    end

    context 'when no kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "0.0".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.highest_kilometres).to eq(0)
      end
    end

    context 'when kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the highest number of kilometres walked in a day' do
        expect(user.highest_kilometres).to eq('3.62'.to_d)
      end
    end
  end

  describe '#highest_kilometre_date' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns a no kilometres recorded message' do
        expect(user.highest_kilometre_date).to eq('No kilometres recorded')
      end
    end

    context 'when no kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "0.0".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.highest_kilometre_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the date of the highest kilometres walked' do
        expect(user.highest_kilometre_date).to eq(Date.parse("02-10-2016"))
      end
    end

    context 'when more than one date has the highest kilometres walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "3.62".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the first date' do
        expect(user.highest_kilometre_date).to eq(Date.parse("01-10-2016"))
      end
    end
  end

  describe '#highest_steps' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.highest_steps).to eq(0)
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

  describe '#highest_calories_burned' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.highest_calories_burned).to eq(0)
      end
    end

    context 'when no calories have been burned' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 0, steps: 0, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.highest_calories_burned).to eq(0)
      end
    end

    context 'when calories have been burned' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the highest calories burned in a day' do
        expect(user.highest_calories_burned).to eq(1503)
      end
    end
  end

  describe '#highest_calories_burned_date' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns a no calories message' do
        expect(user.highest_calories_burned_date).to eq('No calories recorded')
      end
    end

    context 'when no calories have been burned' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 0, steps: 0, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.highest_calories_burned_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when calories have been burned' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the date that the highest calories were burned' do
        expect(user.highest_calories_burned_date).to eq(Date.parse("02-10-2016"))
      end
    end

    context 'when two dates have the highest number of calories burned' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1388, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the first date' do
        expect(user.highest_calories_burned_date).to eq(Date.parse("01-10-2016"))
      end
    end
  end

  describe '#lowest_floors' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.lowest_floors).to eq(0)
      end
    end

    context 'when no floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2340, distance: "1.63".to_d, floors: 0, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.lowest_floors).to eq(0)
      end
    end

    context 'when floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the lowest number of stairs climbed in a day' do
        expect(user.lowest_floors).to eq(13)
      end
    end
  end

  describe '#lowest_floor_date' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns a no floors message' do
        expect(user.lowest_floor_date).to eq("No floors recorded")
      end
    end

    context 'when no floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2340, distance: "1.63".to_d, floors: 0, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.lowest_floor_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when floors have been climbed' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the date of the lowest floors climbed' do
        expect(user.lowest_floor_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when two dates have the lowest floors' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 13, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the first date' do
        expect(user.lowest_floor_date).to eq(Date.parse("01-10-2016"))
      end
    end
  end

  describe '#lowest_steps' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.lowest_steps).to eq(0)
      end
    end

    context 'when no steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 0, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.lowest_steps).to eq(0)
      end
    end

    context 'when steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the lowest number of steps walked in a day' do
        expect(user.lowest_steps).to eq(2459)
      end
    end
  end

  describe '#lowest_step_date' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns no steps recorded' do
        expect(user.lowest_step_date).to eq("No steps recorded")
      end
    end

    context 'when no steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 0, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.lowest_step_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when steps have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the date that the lowest steps were walked' do
        expect(user.lowest_step_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when more than one date has the lowest steps' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 2459, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the first date' do
        expect(user.lowest_step_date).to eq(Date.parse("01-10-2016"))
      end
    end
  end

  describe '#lowest_kilometres' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.lowest_kilometres).to eq(0)
      end
    end

    context 'when no kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "0.0".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.lowest_kilometres).to eq(0)
      end
    end

    context 'when kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the lowest kilometres walked in a day' do
        expect(user.lowest_kilometres).to eq("1.63".to_d)
      end
    end
  end

  describe '#lowest_kilometre_date' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns a no kilometres message' do
        expect(user.lowest_kilometre_date).to eq("No kilometres recorded")
      end
    end

    context 'when no kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "0.0".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.lowest_kilometre_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when kilometres have been walked' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the date of the lowest kilometres walked' do
        expect(user.lowest_kilometre_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when more than one date has the lowest kilometres' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "3.62".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 499)
      end

      it 'returns the first date' do
        expect(user.lowest_kilometre_date).to eq(Date.parse("01-10-2016"))
      end
    end
  end

  describe '#highest_very_active_minutes' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns 0' do
        expect(user.highest_very_active_minutes).to eq(0)
      end
    end

    context 'when there have been no active minutes' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 0, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns 0' do
        expect(user.highest_very_active_minutes).to eq(0)
      end
    end

    context 'when there have been active minutes' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 18, minutes_very_active: 19, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 14, minutes_very_active: 31, activity_calories: 499)
      end

      it 'returns the highest very active minutes in a day' do
        expect(user.highest_very_active_minutes).to eq(31)
      end
    end
  end

  describe '#highest_very_active_date' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns no activity recorded' do
        expect(user.highest_very_active_date).to eq("No activity recorded")
      end
    end

    context 'when there have been no active minutes' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 0, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.highest_very_active_date).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when there have been active minutes' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 18, minutes_very_active: 19, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 14, minutes_very_active: 31, activity_calories: 499)
      end

      it 'returns the date with the most very active minutes' do
        expect(user.highest_very_active_date).to eq(Date.parse("02-10-2016"))
      end
    end

    context 'when two days have the same number of very active minutes' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 18, minutes_very_active: 31, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 14, minutes_very_active: 31, activity_calories: 499)
      end

      it 'returns the first date' do
        expect(user.highest_very_active_date).to eq(Date.parse("01-10-2016"))
      end
    end
  end

  describe '#most_active_day' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns no activity recorded' do
        expect(user.most_active_day).to eq("No activity recorded")
      end
    end

    context 'when there have been no active minutes' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 0, minutes_fairly_active: 0, minutes_very_active: 0, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.most_active_day).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when there have been active minutes' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 18, minutes_very_active: 19, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 14, minutes_very_active: 31, activity_calories: 499)
      end

      it 'returns the date with the highest activity' do
        expect(user.most_active_day).to eq(Date.parse("02-10-2016"))
      end
    end

    context 'when two days have the same number of active minutes' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 633, minutes_lightly_active: 163, minutes_fairly_active: 18, minutes_very_active: 31, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 163, minutes_fairly_active: 18, minutes_very_active: 31, activity_calories: 499)
      end

      it 'returns the first date' do
        expect(user.most_active_day).to eq(Date.parse("01-10-2016"))
      end
    end
  end

  describe '#least_active_day' do
    before { user.save! }

    context 'when no activities have been recorded' do
      it 'returns no activity recorded' do
        expect(user.least_active_day).to eq("No activity recorded")
      end
    end

    context 'when no minutes_sedentary have been recorded' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 0, minutes_lightly_active: 163, minutes_fairly_active: 18, minutes_very_active: 19, activity_calories: 354)
      end

      it 'returns the date of the activity' do
        expect(user.least_active_day).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when minutes_sedentary have been recorded' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 18, minutes_very_active: 19, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 633, minutes_lightly_active: 209, minutes_fairly_active: 14, minutes_very_active: 31, activity_calories: 499)
      end

      it 'returns the date of the highest minutes sedentary' do
        expect(user.least_active_day).to eq(Date.parse("01-10-2016"))
      end
    end

    context 'when two days have the same number of minutes_sedentary' do
      before do
        user.activities.create!(date: Date.parse("01-10-2016"), calories_burned: 1388, steps: 2459, distance: "1.63".to_d, floors: 13, minutes_sedentary: 676, minutes_lightly_active: 163, minutes_fairly_active: 18, minutes_very_active: 19, activity_calories: 354)
        user.activities.create!(date: Date.parse("02-10-2016"), calories_burned: 1503, steps: 5483, distance: "3.62".to_d, floors: 17, minutes_sedentary: 676, minutes_lightly_active: 209, minutes_fairly_active: 14, minutes_very_active: 31, activity_calories: 499)
      end

      it 'returns the first date' do
        expect(user.least_active_day).to eq(Date.parse("01-10-2016"))
      end
    end
  end
end
