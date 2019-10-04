class Exchange::ThreeController < ExchangesController
  def index
    require 'net/http'
    require 'json'

    @base_url_name = "fixer.io"
    @base_url = "http://data.fixer.io/api/latest?access_key=#{ENV["FIXER_API_KEY"]}"

    begin
      @input = params[:input]
      @base = "EUR"
      @rate_to = params[:rate_to]

      url = "#{@base_url}&base=#{@base}"
      uri = URI(url)

      response = Net::HTTP.get(uri)
      response_obj = JSON.parse(response)
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
      redirect_to error_path
    end
  end

  def error
  end
end
