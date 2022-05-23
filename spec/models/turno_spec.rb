# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Turno, type: :model do
    before(:each) do
        @turno = Turno.new(address_in: 'Campus',
                           address_out: 'Casa',
                           capacity: rand(1..10),
                           route: 'IDA',
                           day: 'MARTES',
                           hour: '15:30')
    end

    it 'is valid with all valid attributes' do
        expect(@turno).to be_valid
    end

    it 'is not valid without an IN address' do
        @turno.address_in = nil
        expect(@turno).not_to be_valid
    end

    it 'is not valid without an OUT address' do
        @turno.address_out = nil
        expect(@turno).not_to be_valid
    end

    it 'is not valid without a >0 capacity' do
        @turno.capacity = 0
        expect(@turno).not_to be_valid
    end

    it 'is not valid without a >0 capacity' do
        @turno.capacity = -1
        expect(@turno).not_to be_valid
    end

    it 'is not valid without route' do
        @turno.route = nil
        expect(@turno).not_to be_valid
    end

    it 'is not valid without a IDA/VUELTA route' do
        @turno.route = 'viaje'
        expect(@turno).not_to be_valid
    end

    it 'is not valid with an empty day' do
        @turno.day = nil
        expect(@turno).not_to be_valid
    end

    it 'is not valid without a valid day' do
        @turno.day = 'a'
        expect(@turno).not_to be_valid
    end

    it 'is not valid without a non-hour input' do
        @turno.hour = 'a'
        expect(@turno).not_to be_valid
    end

    it 'is not valid without an hour' do
        @turno.hour = nil
        expect(@turno).not_to be_valid
    end
end
