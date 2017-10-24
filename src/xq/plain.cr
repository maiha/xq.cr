class Xq::Plain
  include Xq

  def initialize(xml : String, options : Options? = nil)
    self.doc = XML.parse(xml)
    self.options = options || Options.new
    self.nodes = [doc]
  end

  def css(filter : CssFilter)
    nodes = Array(XML::Node).new

    self.nodes.each do |node|
      node.xpath_nodes("//*").each do |n|
        if filter.match?(n)
          nodes << n
        end
      end
    end
    return nodes
  end
end
