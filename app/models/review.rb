# frozen_string_literal: true

class Review < ApplicationRecord
    validates :score, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    validates :content, presence: true
    belongs_to :user, optional: true
    belongs_to :receiver, class_name: 'User', optional: true
end
