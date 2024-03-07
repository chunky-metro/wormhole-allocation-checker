require 'sinatra'
require 'sinatra/reloader' if development?
require 'erubis'
require './lib/wormhole.rb'


get '/' do
  erb :index
end

post '/check' do
  address = params[:address]
  chain = params[:chain]

  if address.empty? || chain.empty?
    @error = "Address and chain must be provided."
    return erb :index
  end

  checker = WormholeAllocationChecker.new(address, chain)
  @result = checker.result

  erb :index
end
