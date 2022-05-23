# frozen_string_literal: true

class Membership < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :turno, optional: true
end
