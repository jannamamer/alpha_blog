# frozen_string_literal: true

class LookUp < ApplicationRecord
  validates :group, presence: true,
                    length: { minimum: 3, maximum: 25 },
                    uniqueness: { scope: :name }

  validates :name, presence: true,
                   length: { minimum: 3, maximum: 25 },
                   uniqueness: { scope: :group }
end
