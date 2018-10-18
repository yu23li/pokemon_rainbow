class Pokemon < ApplicationRecord
  belongs_to :pokedex

  validates :name, presence: true, uniqueness: true
end
