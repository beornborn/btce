class TradesController < ApplicationController
  def index
    @data = {}
    names = StrategyResult.pluck(:strategy).uniq
    names.each do |name|
      @data[name] = {usd: StrategyResult.last_usd(name)}
    end
  end
end