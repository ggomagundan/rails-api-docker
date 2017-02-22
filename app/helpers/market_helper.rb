module MarketHelper
  def fetch_markets
    markets =  $redis.get("markets")
    if markets.nil?
      markets = Market.all.to_json
      $redis.set("markets", markets)
    end
    @redis_markets = JSON.load markets
  end
end
