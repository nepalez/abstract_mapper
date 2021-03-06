# encoding: utf-8

begin
  require "hexx-suit"
  Hexx::Suit.load_metrics_for(self)
rescue LoadError
  require "hexx-rspec"
  Hexx::RSpec.load_metrics_for(self)
end

# Loads the code under test
require "abstract_mapper"

RSpec.configure do |config|
  config.around do |example|
    module AbstractMapper::Test; end
    example.run
    AbstractMapper.send :remove_const, :Test
  end
end

# Loads specific matchers
require "immutability/rspec"
