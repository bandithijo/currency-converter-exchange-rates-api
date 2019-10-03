namespace :exchange do
  desc "Rake task to get exchange rates"
  task :rates, [:base, :rate_to] => :environment do |t, args|
    puts "Fetching exchange rates..."
    puts '-' * 12
    puts "1 #{args[:base]} to #{args[:rate_to]}", fetch_rate_from_api("#{args[:base]}", "#{args[:rate_to]}")
    puts '-' * 12
    puts "#{Time.now} -- Success!"
  end

  private

  def fetch_rate_from_api(base, rate_name)
    require 'net/http'
    require 'json'
    # Testing using open API without API_KEY required
    site = "https://api.exchangeratesapi.io/latest"
    url = "#{site}?&base=#{base}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    response_obj = JSON.parse(response)
    rate = response_obj['rates']["#{rate_name}"]
    return rate
  end
end

# TODO
# 1. Create seed for exchange_rates for rate_name: ['MYR', 'CNY']
