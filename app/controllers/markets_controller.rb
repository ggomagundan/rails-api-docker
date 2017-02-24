class MarketsController < ApplicationController

  include MarketHelper

  before_action :set_market, only: [:show, :update, :destroy]

  after_action only: [:index] { set_pagination_headers :markets }

  def index
    fetch_markets
    @markets = Kaminari.paginate_array(@redis_markets).page(page).per(per_page)
    #@markets = Market.page(page).per(per_page)
    @r_markets = @markets.compact.map { |json| Market.new(json) }

    render json: @r_markets, include: ['market_tags']
  end

  def show
    MarketJob.perform_later(@market)
    render json: @market

  end

  def create
    @market = Market.new(market_params)

    if @market.save
      render :show, status: :created, location: @market
    else
      render json: @market.errors, status: :unprocessable_entity
    end
  end

  def update
    if @market.update(market_params)
      render :show, status: :ok, location: @market
    else
      render json: @market.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @market.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market

      #@market = Market.find(params[:id])
      fetch_market_from_id(params[:id])
      @market = Market.new(@redis_market)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_params
      params.require(:market).permit(:title, :body)
    end

end



