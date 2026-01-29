require_relative '../lib/dark_trader.rb'

RSpec.describe "fetch_crypto_data" do
  it "returns an array" do
    expect(fetch_crypto_data).to be_a(Array)
  end

  it "returns an array of hashes" do
    result = fetch_crypto_data
    expect(result.first).to be_a(Hash)
  end

  it "each hash contains a symbol and a price" do
    result = fetch_crypto_data
    first_hash = result.first

    key = first_hash.keys.first
    value = first_hash.values.first

    expect(key).to be_a(String)
    expect(value).to be_a(Float)
  end
end