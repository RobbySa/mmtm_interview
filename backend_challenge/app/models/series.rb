class Series < ApplicationRecord
  validates :name, presence: true

  has_many :books
end