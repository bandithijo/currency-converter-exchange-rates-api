class ExchangesController < ApplicationController
  def index
    redirect_to exchange_one_index_path
  end

  def error
  end
end
