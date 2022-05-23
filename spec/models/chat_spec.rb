# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chat, type: :model do
    before(:each) do
        @chat = Chat.new(content: 'Content paragraph')
    end

    it 'is valid with all valid attributes' do
        expect(@chat).to be_valid
    end

    it 'is not valid with empty content' do
        @chat.content = ''
        expect(@chat).not_to be_valid
    end
end
