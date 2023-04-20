require_relative '../lib/mayors'

describe 'get_townhall_list' do
  it 'returns a hash' do
    expect(get_townhall_list('https://annuaire-des-mairies.com/val-d-oise.html')).to be_a(Hash)
  end

  it 'returns a non-empty hash' do
    expect(get_townhall_list('https://annuaire-des-mairies.com/val-d-oise.html')).not_to be_empty
  end

  it 'returns a hash with the correct keys' do
    expect(get_townhall_list('https://annuaire-des-mairies.com/val-d-oise.html').keys).to include('ABLEIGES')
  end

  it 'returns a hash with the correct values' do
    expect(get_townhall_list('https://annuaire-des-mairies.com/val-d-oise.html').values).to include('mairie.ableiges95@wanadoo.fr')
  end
end