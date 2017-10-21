class Xq::XPath
  include Xq

  var namespaces : Array(XML::Namespace)

  def initialize(xml : String, options : Options? = nil)
    self.doc = XML.parse(xml)
    self.options = options || Options.new
    self.nodes = [doc]
    self.namespaces = doc.root.not_nil!.namespace_scopes
  end

  def css(query : String)
    nodes = Array(XML::Node).new
    path  = Xq.css2xpath(query)
    self.nodes.each do |node|
      node.xpath_nodes(path, namespaces_for_xpath).each do |node|
        nodes << node
      end
    end
    return nodes
  end

  # convert namespaces for `xpath`
  protected def namespaces_for_xpath
    namespaces.map{|n| {n.prefix, n.href}}
  end
end

