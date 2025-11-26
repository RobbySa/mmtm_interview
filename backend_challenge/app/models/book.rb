class Book < ApplicationRecord
  validates :isbn13, uniqueness: true

  belongs_to :series, optional: true
  has_and_belongs_to_many :authors

  delegate :name, to: :series, prefix: true, allow_nil: true
end