class Skill < ApplicationRecord

  validates :name, length: { maximum: 45 }, presence: true, uniqueness: true
  validates :power, numericality: { greater_than: 0 }
  validates :max_pp, numericality: { greater_than: 0 }

  ELEMENT_TYPE = ["Normal","Fire","Fighting","Water","Flying","Grass","Poison","Electric","Ground","Psychic",
                  "Rock","Ice","Bug","Dragon","Ghost","Dark","Steel","Fairy"]
end
