require 'http'

class WormholeAllocationChecker
  BASE_URL = "https://prod-flat-files-min.wormhole.com"
  CHAINS = {
    Solana: 1,
    EVM: 2,
    Terra: 3,
    Algorand: 8,
    Injective: 19,
    Osmosis: 20,
    Sui: 21,
    Aptos: 22
  }
  attr_reader :address, :chain

  def initialize(address, chain)
    @address = set_address(address)
    @chain = chain
  end

  def set_address(address)
    chain.to_i == 2 ? address.downcase : address
  end

  def url
    "#{BASE_URL}/#{address}_#{chain}.json"
  end

  def result
    HTTP.get(url).parse(:json).fetch("amount").to_i / 1_000_000_000.to_f
  rescue
    "No allocation found"
  end
end
