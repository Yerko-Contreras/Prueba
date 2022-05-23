# frozen_string_literal: true

require 'faker'

FactoryBot.define do
    factory :review do
        score { rand(1..5) }
        content { Faker::Lorem.paragraph }
    end
end
