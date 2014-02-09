class Strategy < ActiveRecord::Base
  has_one :trade
  serialize :options

  def to_s
    "#{name} #{options}"
  end

  def self.find_or_create_strategy name, options
    Strategy.create_with(options: options).find_or_create_by(name: name, options_hash: options.to_s)
  end
end
