# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
    before(:each) do
        @user = User.new(email: 'test@mail.com',
                         password: 'testpassword123',
                         password_confirmation: 'testpassword123',
                         address: 'calle123',
                         phone: '56956569',
                         username: 'Test Name')
    end

    it 'is valid with valid attributes' do
        expect(@user).to be_valid
    end

    it 'is not valid with empty username' do
        @user.username = nil
        expect(@user).not_to be_valid
    end

    it 'is not valid with empty address' do
        @user.address = nil
        expect(@user).not_to be_valid
    end

    it 'is not valid with empty phone' do
        @user.phone = nil
        expect(@user).not_to be_valid
    end

    it 'is not valid with phone that is too short' do
        @user.phone = '1234567'
        expect(@user).not_to be_valid
    end

    it 'is not valid with phone that is too long' do
        @user.phone = '123456789'
        expect(@user).not_to be_valid
    end
end
