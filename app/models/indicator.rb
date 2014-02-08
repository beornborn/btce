class Indicator < ActiveRecord::Base
  has_many :ichimokus
  serialize :options
end