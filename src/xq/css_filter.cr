record Xq::CssFilter,
  filter : String,
  prefix : String? = nil,
  ignore : Bool = false do

  def match?(node : XML::Node)
    if node_prefix = node.namespace.try(&.prefix)
      return false if prefix && node_prefix != prefix
    end
    return node.name =~ build_name_regex
  end

  def to_s(io : IO)
    if prefix
      io << "#{prefix}:"
    end
    io << filter
  end

  private def build_name_regex
    src  = filter.split("*").map{|i| Regex.escape(i)}.join(".*")
    opts = ignore ? Regex::Options::IGNORE_CASE : Regex::Options::None
    Regex.new("^#{src}$", opts)
  end

  def self.build(filter : String, ignore = false)
    case filter
    when /^(.*?):(.*)$/
      new(filter: $2, prefix: $1, ignore: ignore)
    else
      new(filter: filter, ignore: ignore)
    end
  end
end
