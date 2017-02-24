class MarketSerializer < ApplicationSerializer

  attributes :id, :market_name, :location, :created_at, :url#, :view_count

#  has_many :market_tags

  def url
    market_path(object, format: :json)
  end

end
