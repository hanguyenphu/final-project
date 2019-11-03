# frozen_string_literal: true

class About < ApplicationRecord
  validates :header, presence: true, length: { minimum: 1 }
  validates :content, presence: true
  has_one_attached :image
end
