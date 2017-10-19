require "xml"

require "app"

class Xq
  property xml : XML::Node

  def initialize(buf : String)
    @xml = XML.parse(buf)
  end

  def execute(pattern) : String
    # v0.1.0 ignores given pattern. just format all nodes.
    @xml.to_s
  end
end

require "./xq/*"
