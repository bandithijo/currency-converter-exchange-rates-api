class Exchange::FourController < ExchangesController
  def index
    require 'net/http'
    require 'json'

    @base_url_name = "openexchangerates.org"
    @base_url = "https://openexchangerates.org/api/latest.json?app_id=#{ENV["OPENEXCHANGE_API_KEY"]}"

    begin
      @input = params[:input]
      @base = "USD"
      @rate_to = params[:rate_to]

      # Build URI with your app ID and base currency:
      uri = URI("#{@base_url}&base=#{@base}")

      # Submit get request with your URI and parse results as JSON:
      response_obj = JSON.parse(Net::HTTP.get(uri))

      @rate = response_obj['rates']["#{@rate_to}"]
      @rates = response_obj['rates']
      @exchanges = @input.to_f * @rate.to_f

      unless @exchanges == 0
        render :index
      end
    rescue SocketError
      redirect_to error_path
    rescue Errno::ENETUNREACH
      redirect_to error_path
    rescue Errno::ECONNREFUSED
      redirect_to error_path
    rescue NoMethodError
      base = "USD"
      uri = URI("https://openexchangerates.org/api/latest.json?app_id=#{ENV["OPENEXCHANGE_API_KEY"]}&base=#{base}")
      response_obj = JSON.parse(Net::HTTP.get(uri))
      @rate = response_obj["rates"]["#{@rate_to}"]
      @rates = response_obj["rates"]
    end
  end

  def error
  end
end
