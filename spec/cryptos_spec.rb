require_relative '../lib/cryptos'

describe "#crypto_scrapper" do
  it 'returns a hash of cryptocurrency names and prices' do
    expect(crypto_scrapper).to be_a(Hash)
  end

  it 'returns a non-empty hash' do
    expect(crypto_scrapper).not_to be_empty
  end

  it 'returns a hash with at least 10 entries' do
    expect(crypto_scrapper.size).to be == 20
  end

  it 'returns a hash with valid cryptocurrency names' do
    expect(crypto_scrapper.keys).to all(match(/[A-Z]{3,}/))
  end
  
end
