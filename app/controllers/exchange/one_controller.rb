class Exchange::OneController < ExchangesController
  def index
    require 'net/http'
    require 'json'

    @base_url_name = "exchangeratesapi.io"
    @base_url = "https://api.exchangeratesapi.io/latest?"

    begin
      @input = params[:input]
      @base = params[:base]
      @rate_to = params[:rate_to]

      url = "#{@base_url}&base=#{@base}"
      uri = URI(url)

      response = Net::HTTP.get(uri)
      response_obj = JSON.parse(response)
      @rate = response_obj['rates']["#{@rate_to}"]
      @rates = response_obj['rates']
      @exchanges = @input.to_f * @rate.to_f

      unless @exchanges == 0
        render 'index'
      end
    rescue SocketError
      redirect_to error_path
    rescue Errno::ENETUNREACH
      redirect_to error_path
    rescue Errno::ECONNREFUSED
      redirect_to error_path
    end
  end

  def error
  end
end
