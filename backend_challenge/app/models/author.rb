class Author < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :books
end