class Category < ApplicationRecord
  validates :name, uniqueness: true
  validates :slug, uniqueness: true
end
