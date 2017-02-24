# json.array! @posts, partial: 'posts/post', as: :post
json.data do |json|
  json.array! @markets do |market|
    json.id market["id"]
    json.market_name market["market_name"]
    json.location market["location"]
    json.created_at l(DateTime.parse(market["created_at"]), format: :short)
    json.url market_url(id: market["id"], format: :json)

    #json.extract! market, :id, :market_name, :location
    #json.created_at l(market.created_at, format: :short)
    #json.url market_url(market, format: :json)
  end
end
json.is_end @markets.last_page?
json.next_page path_to_next_page(@markets)
json.prev_page path_to_prev_page(@markets)
