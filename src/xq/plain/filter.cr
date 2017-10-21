record Xq::Plain::Filter,
  name : String,
  prefix : String? = nil do

  def match?(node : XML::Node)
    if node_prefix = node.namespace.try(&.prefix)
      return false if prefix && node_prefix != prefix
    end
    return node.name =~ build_name_regex
  end

  private def build_name_regex
    v = name.split("*").map{|i| Regex.escape(i)}.join(".*")
    /^#{v}$/
  end
  
  def self.build(filter : String)
    case filter
    when /^(.*?):(.*)$/
      new($2, $1)
    else
      new(filter)
    end
  end
end  
