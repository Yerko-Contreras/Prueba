# frozen_string_literal: true

class Turno < ApplicationRecord
    before_validation { self.route = route.upcase unless route.nil? }
    before_validation { self.day = day.upcase unless day.nil? }
    validates :capacity, presence: true,
                         numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
    validates :address_in, presence: true
    validates :address_out, presence: true
    validates :route, presence: true, confirmation: { case_sensitive: false },
                      inclusion: { in: %w[IDA VUELTA] }
    validates :day, presence: true,
                    inclusion: { in: %w[LUNES MARTES MIERCOLES JUEVES VIERNES SABADO DOMINGO] }
    validates :hour, presence: true, format: { with: /[0-23][0-9]:[0-5][0-9]/ }, length: { is: 5 }
    has_many :chats, dependent: :destroy
    has_many :requests, dependent: :destroy
    has_many :passengers, class_name: 'User'
    has_many :memberships, dependent: :destroy
    has_many :users, through: :memberships
    belongs_to :owner, class_name: 'User', foreign_key: 'user_id', optional: true
end
