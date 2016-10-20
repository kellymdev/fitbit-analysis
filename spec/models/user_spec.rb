require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe 'name' do
      let(:user) { User.new(name: name, email: "test@example.com", password: "test12") }

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
end
