# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable

  before_save { self.email = email.downcase }

  has_one :payment, dependent: :destroy
  accepts_nested_attributes_for :payment, allow_destroy: true

  has_many :articles, dependent: :destroy
  has_many :messages
  has_many :friendships
  has_many :friends, through: :friendships

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

  def full_name
    [first_name, ' ', last_name].join
  end

  def friends_with?(friend, current_user)
    User.find(current_user.id).friends.where(id: friend.id).exists?
  end

  def not_friends_with?(friend, current_user)
    !friends_with?(friend, current_user)
  end

  def self.search(param, current_user)
    User.where('CONCAT(first_name, last_name, email) LIKE ?', "%#{param.strip}%")
        .where.not(id: current_user.id)
        .where.not(id: current_user.friends.map(&:id))
  end
end
