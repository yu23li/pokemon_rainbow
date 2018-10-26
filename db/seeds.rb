require 'csv'

csv_pokedex_text = File.read(Rails.root.join('lib', 'seeds', 'list_pokedex.csv'))
csv_pokedex = CSV.parse(csv_pokedex_text, :headers => true, :encoding => 'ISO-8859-1')
csv_pokedex.each do |row|
  t = Pokedex.new
  t.name = row['name']
  t.base_health_point = row['base_health_point']
  t.base_attack = row['base_attack']
  t.base_defence = row['base_defence']
  t.base_speed = row['base_speed']
  t.element_type = row['element_type']
  t.image_url = row['image_url']
  t.save
end

puts "#{Pokedex.count} Pokedexes saved"

csv_skill_text = File.read(Rails.root.join('lib', 'seeds', 'list_skill.csv'))
csv_skill = CSV.parse(csv_skill_text, :headers => true, :encoding => 'ISO-8859-1')
csv_skill.each do |row|
  t = Skill.new
  t.name = row['name']
  t.power = row['power']
  t.max_pp = row['max_pp']
  t.element_type = row['element_type']
  t.created_at = row['created_at']
  t.updated_at = row['element_type']
  t.save
end

puts "#{Skill.count} Skills saved"