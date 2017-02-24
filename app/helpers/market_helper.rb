module MarketHelper
  def fetch_markets
    markets =  $redis.get("markets")
    if markets.nil?
      markets = Market.all.to_json
      $redis.set("markets", markets)
      $redis.expire("markets",6.hour.to_i)
    end
    @redis_markets = JSON.load markets
  end

  def fetch_market_from_id(id)
    market =  $redis.get("market_#{id}")
    if market.nil?
      market = Market.where(id: id).first.to_json
      $redis.set("market_#{id}", market)
      $redis.expire("market_#{id}",6.hour.to_i)
    end
    @redis_market = JSON.load market
  end

 
end
