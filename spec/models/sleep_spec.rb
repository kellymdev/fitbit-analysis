require 'rails_helper'

RSpec.describe Sleep, type: :model do
  describe 'validations' do
    describe 'minutes_asleep' do
      it 'is valid with minutes of 0' do
        expect(Sleep.new(minutes_asleep: 0)).to have(0).errors_on(:minutes_asleep)
      end

      it 'is valid with a positive minutes value' do
        expect(Sleep.new(minutes_asleep: 10)).to have(0).errors_on(:minutes_asleep)
      end

      it 'has errors with a negative minutes value' do
        expect(Sleep.new(minutes_asleep: -1)).to have(1).error_on(:minutes_asleep)
      end
    end

    describe 'minutes_awake' do
      it 'is valid with minutes of 0' do
        expect(Sleep.new(minutes_awake: 0)).to have(0).errors_on(:minutes_awake)
      end

      it 'is valid with a positive minutes value' do
        expect(Sleep.new(minutes_awake: 9)).to have(0).errors_on(:minutes_awake)
      end

      it 'has errors with a negative minutes value' do
        expect(Sleep.new(minutes_awake: -1)).to have(1).error_on(:minutes_awake)
      end
    end

    describe 'number_of_awakenings' do
      it 'is valid with a number_of_awakenings of 0' do
        expect(Sleep.new(number_of_awakenings: 0)).to have(0).errors_on(:number_of_awakenings)
      end

      it 'is valid with a positive number_of_awakenings' do
        expect(Sleep.new(number_of_awakenings: 4)).to have(0).errors_on(:number_of_awakenings)
      end

      it 'has errors with a negative number_of_awakenings value' do
        expect(Sleep.new(number_of_awakenings: -1)).to have(1).error_on(:number_of_awakenings)
      end
    end

    describe 'time_in_bed' do
      it 'is valid with a time_in_bed of 0' do
        expect(Sleep.new(time_in_bed: 0)).to have(0).errors_on(:time_in_bed)
      end

      it 'is valid with a positive time_in_bed value' do
        expect(Sleep.new(time_in_bed: 7)).to have(0).errors_on(:time_in_bed)
      end

      it 'has errors with a negative time_in_bed value' do
        expect(Sleep.new(time_in_bed: -1)).to have(1).error_on(:time_in_bed)
      end
    end
  end
end
