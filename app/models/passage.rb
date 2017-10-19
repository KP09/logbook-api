class Passage < ApplicationRecord
  validates :departure_port, presence: true
  validates :arrival_port, presence: true
  validates :departure_date, presence: true
  validates :arrival_date, presence: true
  validates :description, presence: true
  validates :miles, presence: true
  validates :night_hours, presence: true
  validates :role, presence: true
  validates :overnight, presence: true
  validates :tidal, presence: true
  validates :ocean_passage, presence: true
end
