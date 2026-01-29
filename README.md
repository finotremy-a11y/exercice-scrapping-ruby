# Scrappeur Fou

A collection of web scrapers built with Ruby, using Nokogiri for HTML parsing and Open-URI for fetching web pages.

## dark_trader.rb

A cryptocurrency price scraper that fetches real-time data from CoinMarketCap.

**Features:**
- Scrapes cryptocurrency names and prices from CoinMarketCap
- Returns data as an array of hashes with symbol and price pairs
- Cleans price data by removing dollar signs and commas

**Usage:**
```ruby
ruby lib/dark_trader.rb
```

**Output format:**
```ruby
[
  { "BTC" => 45000.50 },
  { "ETH" => 2500.75 },
  ...
]
```

## mairie_christmas.rb

A French townhall email scraper that collects contact information from municipalities in Val-d'Oise.

**Features:**
- Extracts townhall URLs from the Annuaire des Mairies (French municipalities directory)
- Scrapes email addresses from each townhall's website
- Handles two email formats: mailto links and plain text emails
- Uses regex pattern matching to find email addresses in raw page text

**Usage:**
```ruby
ruby lib/mairie_christmas.rb
```

**Output format:**
```ruby
[
  { "town_name" => "email@example.com" },
  { "another_town" => "contact@mairie.fr" },
  ...
]
```

## deputes.rb

A French deputies scraper that collects information about members of the National Assembly (Assemblée Nationale).

**Features:**
- Scrapes deputy URLs from the National Assembly official directory
- Extracts deputy information: first name, last name, and email address
- Parses and cleans names from HTML markup
- Extracts email from mailto links

**Usage:**
```ruby
ruby lib/deputes.rb
```

**Output format:**
```ruby
[
  { "first_name" => "Jean", "last_name" => "DUPONT", "email" => "jean.dupont@assemblee-nationale.fr" },
  { "first_name" => "Marie", "last_name" => "MARTIN", "email" => "marie.martin@assemblee-nationale.fr" },
  ...
]
```

**⚠️ Note:**
This scraper currently has issues with the target URL structure. The website may have changed its HTML structure or require different selectors for proper scraping. The scraper may not return complete data until the XPath selectors are updated to match the current website layout.

## Dependencies

- `nokogiri` - HTML parsing
- `open-uri` - Fetching web pages

## Testing

Run the test suite with:
```bash
rspec
```

Individual tests can be run with:
```bash
rspec spec/dark_trader_spec.rb
rspec spec/mairie_christmas_spec.rb
```
