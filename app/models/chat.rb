# frozen_string_literal: true

class Chat < ApplicationRecord
    validates :content, presence: true
    belongs_to :turno, optional: true
    belongs_to :user, optional: true
end
