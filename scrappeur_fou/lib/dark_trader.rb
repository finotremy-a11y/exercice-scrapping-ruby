require 'nokogiri'
require 'open-uri'

def fetch_crypto_data
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  
  crypto_names = page.xpath('//table//tbody//tr//td[3]/div')
  crypto_prices = page.xpath('//table//tbody//tr//td[5]//span')

  result = []

  crypto_names.each_with_index do |name, index|
    # nettoyer le texte
    symbol = name.text.strip
    price = crypto_prices[index].text.gsub('$', '').gsub(',', '').to_f
    result << { symbol => price }
  end
  result
end

if __FILE__ == $0
  puts fetch_crypto_data
end
