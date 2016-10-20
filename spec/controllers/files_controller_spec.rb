require 'rails_helper'

RSpec.describe FilesController, type: :controller do
  let(:user) { User.create!(name: "Bob", email: "test@example.com", password: "test12") }

  before { sign_in user }

  describe '#new' do
    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end
  end
end
