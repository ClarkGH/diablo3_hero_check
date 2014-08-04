class User < ActiveRecord::Base
  # Remember to create a migration!
  validates :battletag_code, numericality: true
  has_many :heros
end
