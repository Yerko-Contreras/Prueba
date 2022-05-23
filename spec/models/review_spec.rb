# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
    before(:each) do
        @review = Review.new(score: '3', content: 'Review content')
    end

    it 'is valid with valid atributes' do
        expect(@review).to be_valid
    end

    it 'is not valid with empty score' do
        @review.score = nil
        expect(@review).not_to be_valid
    end

    it 'is not valid with score higher than 5' do
        @review.score = '7'
        expect(@review).not_to be_valid
    end
end
