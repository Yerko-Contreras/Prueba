# frozen_string_literal: true

class Request < ApplicationRecord
    validates :description, presence: true
    belongs_to :turno, optional: true
    belongs_to :user, optional: true
end
