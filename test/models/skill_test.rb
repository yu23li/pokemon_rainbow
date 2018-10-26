require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  test "invalid Skill" do
    skill = Skill.new
    assert_not skill.save
  end

  test "name of skill must unique" do
    skill_1 = Skill.new
    skill_1.name = "Test"
    skill_1.power = 1
    skill_1.max_pp = 2
    skill_1.element_type = "normal"
    skill_1.save
    assert skill_1.save

    skill_2 = Skill.new
    skill_2.name = "Test"
    skill_1.power = 1
    skill_1.max_pp = 2
    skill_2.element_type = "normal"
    assert_not skill_2.save
  end

  test "element_type must be in element_type" do
    skill_1 = Skill.new
    skill_1.name = "Test"
    skill_1.power = 1
    skill_1.max_pp = 2
    skill_1.element_type = "normal"
    assert skill_1.save

    skill_2 = Skill.new
    skill_2.name = "Test"
    skill_1.power = 1
    skill_1.max_pp = 2
    skill_2.element_type = "haha"
    assert_not skill_2.save
  end

  test "power must greater than 0" do
   skill_1 = Skill.new
   skill_1.name = "Test"
   skill_1.power = -1
   skill_1.max_pp = 2
   skill_1.element_type = "normal"
   assert_not skill_1.save
  end

  test "max_pp must greater than 0" do
   skill_1 = Skill.new
   skill_1.name = "Test"
   skill_1.power = 1
   skill_1.max_pp = -2
   skill_1.element_type = "normal"
   assert_not skill_1.save
  end

end
