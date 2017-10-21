require "spec"
require "../src/xq"

def read_fixture(path)
  File.read("#{__DIR__}/fixtures/#{path}")
end
