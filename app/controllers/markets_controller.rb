class MarketsController < ApplicationController

  include MarketHelper

  before_action :set_market, only: [:show, :update, :destroy]

  after_action only: [:index] { set_pagination_headers :markets }

  def index
    fetch_markets 
    @markets = Kaminari.paginate_array(@redis_markets).page(page).per(per_page)
  end

  def show
    MarketJob.perform_later(@market)
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
      @market = Market.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_params
      params.require(:market).permit(:title, :body)
    end

end



