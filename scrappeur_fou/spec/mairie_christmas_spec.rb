require_relative '../lib/mairie_christmas.rb'

RSpec.describe "Mairie Christmas" do

  describe "#get_townhall_urls" do
    it "returns an array of URLs" do
      urls = get_townhall_urls
      expect(urls).to be_a(Array)
      expect(urls).not_to be_empty
      expect(urls.first).to include("https://www.annuaire-des-mairies.com")
    end
  end

  describe "#get_townhall_email" do
    it "returns an email for a known townhall" do
      email = get_townhall_email("https://www.annuaire-des-mairies.com/95/ableiges.html")
      expect(email).to be_a(String)
      expect(email).to match(/\A[^@\s]+@[^@\s]+\z/)
    end
  end

  describe "#perform" do
    it "returns an array of hashes" do
      result = perform
      expect(result).to be_a(Array)
      expect(result.first).to be_a(Hash)
    end
  end

end