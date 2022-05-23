# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homepages', type: :request do
    before(:each) do
        @attr_user = {
            email: 'test@mail.com',
            password: 'testpassword123',
            password_confirmation: 'testpassword123',
            address: 'calle123',
            phone: '56956569',
            username: 'Test Name',
            admin: true
        }
    end

    describe 'get homepages' do
        it 'should return a successful request' do
            get '/homepages'
            expect(response).to have_http_status(:ok)
        end
    end
end
