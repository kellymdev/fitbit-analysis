require 'rails_helper'
require 'csv'

RSpec.describe CreateDataFromFile, type: :service do
  describe '#call' do
    let(:data_from_file) { CreateDataFromFile.new("file") }

    before do
      expect(CSV).to receive(:foreach).and_return(row)
    end

    context 'with the Activities heading' do
      let(:row) { 'Activities,,,,,,,,,' }

      it "doesn't change the number of activities" do
        expect { data_from_file.call }.not_to change { Activity.count }
      end

      it "doesn't change the number of sleeps" do
        expect { data_from_file.call }.not_to change { Sleep.count }
      end
    end

    context 'with the Sleep heading' do
      let(:row) { 'Sleep,,,,,,,,,' }

      it "doesn't change the number of activities" do
        expect { data_from_file.call }.not_to change { Activity.count }
      end

      it "doesn't change the number of sleeps" do
        expect { data_from_file.call }.not_to change { Sleep.count }
      end
    end

    context 'with a date header row' do
      let(:row) { 'Date,Calories Burned,Steps,Distance,Floors,Minutes Sedentary,Minutes Lightly Active,Minutes Fairly Active,Minutes Very Active,Activity Calories' }

      it "doesn't change the number of activities" do
        expect { data_from_file.call }.not_to change { Activity.count }
      end

      it "doesn't change the number of sleeps" do
        expect { data_from_file.call }.not_to change { Sleep.count }
      end
    end
  end
end
