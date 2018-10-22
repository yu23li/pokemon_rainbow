class Pokemon < ApplicationRecord
  belongs_to :pokedex
  has_many :pokemon_skills
  has_many :skills, through: :pokemon_skills
  has_many :pokemon_battles

  with_options unless: :new_record? do |new|
    new.validates :current_health_point, numericality: { less_than: :max_health_point, greater_than_or_equal_to: 0 }
    new.validates :max_health_point, numericality: { greater_than: 0 }
    new.validates :attack, numericality: { greater_than: 0 }
    new.validates :defence, numericality: { greater_than: 0 }
    new.validates :speed, numericality: { greater_than: 0 }
  end

  validates :name, presence: true, uniqueness: true
  validates :current_experience, numericality: { greater_than_or_equal_to: 0 }
  validates :level, numericality: { greater_than: 0 }
end