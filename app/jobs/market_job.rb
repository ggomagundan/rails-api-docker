class MarketJob < ApplicationJob
  queue_as :default

  def perform(market)

    market.increment! :view_count

  end
end
