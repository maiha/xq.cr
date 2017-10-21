require "xml"
require "app"

module Xq
  var doc        : XML::Node
  var nodes      : Array(XML::Node)
  var options    : Xq::Options

  abstract def css(filter : String) : Xq
end

require "./xq/**"
