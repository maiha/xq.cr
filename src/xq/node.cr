module Xq
  class Node
    getter nodes
    getter namespaces

    def initialize(@nodes : Array(XML::Node), @options : Options, @namespaces : Array(XML::Namespace))
    end
  end
end

