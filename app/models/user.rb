# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable

  before_save { self.email = email.downcase }

  has_many :articles, dependent: :destroy
  has_many :messages
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  self.per_page = 3
end
