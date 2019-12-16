class Recipe < ApplicationRecord
  enum cuisine: {
    American: 1,
    Italian: 2,
    Mexican: 3,
    Asian: 4,
    Other: 5
  }

  validates :title, presence: true, uniqueness: true, length: 1..1024
  validates :cuisine, presence: true, inclusion: {in: Recipe.cuisines.keys.map(&:to_s)}
  validates :instructions, presence: true
  validates :tried_before, inclusion: { in: [true, false] }
  validate :check_date
  validate :no_js_in_instructions

  private

  def check_date
    return if self.planning_to_cook_on.nil?
    unless self.planning_to_cook_on > Time.zone.now
      errors.add :planning_to_cook_on, 'cannot be in the past'
    end
  end

  def no_js_in_instructions
    if instructions.present?
      # TODO: switch to sanitizer
      errors.add :instructions, 'cannot contain javascript' if instructions.downcase =~ /\<\s*script/
      errors.add :instructions, 'cannot contain javascript' if instructions.downcase =~ /on\w*\s*\=/
    end
  end
end
