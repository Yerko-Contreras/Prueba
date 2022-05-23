# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, type: :model do
    before(:each) do
        @request = Request.new(description: 'Description paragraph')
    end
    it 'is valid with valid attributes' do
        expect(@request).to be_valid
    end

    it 'is not valid with an empty description' do
        @request.description = nil
        expect(@request).not_to be_valid
    end
end
