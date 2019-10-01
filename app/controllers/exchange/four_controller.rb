class Exchange::FourController < ExchangesController
  def index
    require 'net/http'
    require 'json'

    @base_url_name = "openexchangerates.org"
    @base_url = "https://openexchangerates.org/api/latest.json?app_id=#{ENV["OPENEXCHANGE_API_KEY"]}"

    @input = params[:input]
    @base = params[:base]
    @rate_to = params[:rate_to]

    url = "#{@base_url}&base=#{@base}"
    uri = URI(url)

    begin
      response = Net::HTTP.get(uri)
      response_obj = JSON.parse(response)
      @rate = response_obj['rates']["#{@rate_to}"]
      @rates = response_obj['rates']
      @exchanges = @input.to_i * @rate.to_i

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
      redirect_to error_path
    end
  end

  def error
  end
end
