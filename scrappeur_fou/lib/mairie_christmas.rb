require 'nokogiri'
require 'open-uri'

def get_townhall_urls
  page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

  links = page.xpath('//a[@class="lientxt"]')

  urls = links.map do |link|
    href = link['href']
    "https://www.annuaire-des-mairies.com#{href}"
  end

  urls
end


def get_townhall_email(url)
  page = Nokogiri::HTML(URI.open(url, "User-Agent" => "Mozilla/5.0"))

  # 1. email dans un lien mailto
  email = page.xpath('//a[contains(@href, "mailto:")]').text.strip
  return email unless email.empty?

  # 2. email dans un texte brut
  raw = page.text
  match = raw.match(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z]{2,}\b/i)
  match ? match[0] : nil
end


def perform
  urls = get_townhall_urls
  result = []

  urls.each do |url|
    town_name = url.split('/').last.gsub('.html', '').downcase
    email = get_townhall_email(url)

    result << { town_name => email }
  end

  result
end

if __FILE__ == $0
  puts perform
end