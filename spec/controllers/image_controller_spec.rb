require 'rails_helper'

RSpec.describe Api::V1::ImagesController, type: :controller do
        it 'has a maximum limit of 100' do
        expect(Image).to receive(:limit).with(100).and_call_original

        get :index, params: { limit: 999 }
    end
end