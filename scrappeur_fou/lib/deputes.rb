require 'nokogiri'
require 'open-uri'

# ---------------------------------------------------------
# 1. Récupération des URLs des députés
# ---------------------------------------------------------
def get_deputy_urls
  page = Nokogiri::HTML(
    URI.open("https://www.assemblee-nationale.fr/dyn/deputes",
             "User-Agent" => "Mozilla/5.0")
  )

  # Tous les liens vers les fiches individuelles
  links = page.xpath('//a[contains(@href, "/dyn/deputes/PA")]')

  links.map do |link|
    "https://www.assemblee-nationale.fr#{link['href']}"
  end
end

# ---------------------------------------------------------
# 2. Extraction des infos d’un député
# ---------------------------------------------------------
def get_deputy_info(url)
  page = Nokogiri::HTML(
    URI.open(url,
             "User-Agent" => "Mozilla/5.0")
  )

  # Nom complet dans <h1 class="titre">
  full_name = page.at_xpath('//h1[contains(@class, "titre")]')&.text&.strip || ""

  # Nettoyage du nom
  clean = full_name.gsub("M. ", "").gsub("Mme ", "").strip
  clean = clean.gsub(/\s+/, " ")

  parts = clean.split(" ")

  first_name = parts.first&.capitalize
  last_name  = parts.last&.upcase

  # Email dans un lien mailto:
  email = page.at_xpath('//a[contains(@href, "mailto:")]')&.text&.strip
  email ||= ""

  {
    "first_name" => first_name,
    "last_name"  => last_name,
    "email"      => email
  }
end

# ---------------------------------------------------------
# 3. Scraper complet
# ---------------------------------------------------------
def perform
  urls = get_deputy_urls
  result = []

  urls.each do |url|
    info = get_deputy_info(url)
    result << info
  end

  result
end

# ---------------------------------------------------------
# Test manuel
# ---------------------------------------------------------
p get_deputy_info(get_deputy_urls.first)