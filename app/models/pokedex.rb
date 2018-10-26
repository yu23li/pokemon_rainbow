class Pokedex < ApplicationRecord
  ELEMENT_TYPE = ["normal","fire","fighting","water","flying","grass","poison","electric","ground","psychic",
                  "rock","ice","bug","dragon","ghost","dark","steel","fairy"]

  validates :name, length: { maximum: 45 }, presence: true, uniqueness: true
  validates :base_health_point, numericality: { greater_than: 0 }, presence: true
  validates :base_attack, numericality: { greater_than: 0 }, presence: true
  validates :base_defence, numericality: { greater_than: 0 }, presence: true
  validates :base_speed, numericality: { greater_than: 0 }, presence: true
  validates :element_type, presence: true, inclusion: { :in => ELEMENT_TYPE }
  validates :image_url, length: { maximum: 225 }, presence: true

  end
