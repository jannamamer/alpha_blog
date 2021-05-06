# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories

  mount_uploader :img_header, ImageUploader

  validates :description, presence: true, length: { minimum: 10, maximum: 5000 }
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :user_id, presence: true

  self.per_page = 12
end
