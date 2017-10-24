require "xml"
require "app"

module Xq
  var doc        : XML::Node
  var nodes      : Array(XML::Node)
  var options    : Xq::Options

  abstract def css(filter : CssFilter) : Array(XML::Node)
  def css(filter : String) : Array(XML::Node)
    css(CssFilter.build(filter))
  end
end

require "./xq/**"
