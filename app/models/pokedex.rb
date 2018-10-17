class Pokedex < ApplicationRecord

  validates :name, length: { maximum: 45 }, presence: true, uniqueness: true
  validates :base_health_point, presence: true
  validates :base_attack, presence: true
  validates :base_defence, presence: true
  validates :base_speed, presence: true
  validates :base_speed, presence: true
  validates :element_type, presence: true
  validates :image_url, length: { maximum: 225 }, presence: true

  ELEMENT_TYPE = ["Normal","Fire","Fighting","Water","Flying","Grass","Poison","Electric","Ground","Psychic",
                  "Rock","Ice","Bug","Dragon","Ghost","Dark","Steel","Fairy"]
end
