class Xq::Plain
  include Xq

  def initialize(xml : String, options : Options? = nil)
    self.doc = XML.parse(xml)
    self.options = options || Options.new
    self.nodes = [doc]
  end

  def css(filter : String)
    nodes = Array(XML::Node).new

    filter = Filter.build(filter)
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
