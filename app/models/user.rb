# frozen_string_literal: true

class User < ApplicationRecord
    has_one_attached :avatar
    after_commit :add_default_avatar, on: %i[create update]
    has_many :chats, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :requests, dependent: :destroy
    has_many :receivers, through: :reviews, class_name: 'User', dependent: :destroy
    has_many :turnos, dependent: :destroy, foreign_key: 'user_id'
    has_many :memberships, dependent: :destroy
    has_many :turnos, through: :memberships

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    validates :username, presence: true, uniqueness: false
    validates :avatar, content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], message: 'no es una imagen' }
    validates_format_of :username, with: /\A[^0-9`!@#$%\^&*+_=]+\z/,
                                   format: { with: ' ', message: 'Agregue nombre y apellido' }
    # add any other characters you'd like to disallow inside the [ brackets ]
    # https://stackoverflow.com/questions/2629422/rails-validating-full-name
    validates :address, presence: true
    validates :phone, presence: true, numericality: { only_integer: true }, length: { is: 8 }

    def avatar_thumbnail
        if avatar.attached? 
            avatar.variant(resize: '120x120!').processed
        else
            '/default_profile.jpeg'
        end
    end

    private

    def add_default_avatar
        return if avatar.attached?
        
        if admin
            avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.jpeg')),
                        filename: 'default_profile.jpg', content_type: 'image/jpg')
        end
    end
end
