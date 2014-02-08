class Exchange < ActiveRecord::Base
  serialize :options
  has_many :trades
end
