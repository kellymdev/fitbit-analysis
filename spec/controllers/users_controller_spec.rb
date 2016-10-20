require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create!(name: "Bob", email: "test@example.com", password: "test12") }

  before { sign_in user }

  describe '#dashboard' do
    it 'renders the dashboard template' do
      get :dashboard

      expect(response).to render_template(:dashboard)
    end
  end
end
