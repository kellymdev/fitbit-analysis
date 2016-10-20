require 'rails_helper'

RSpec.describe FilesController, type: :controller do
  describe '#new' do
    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end
  end
end
