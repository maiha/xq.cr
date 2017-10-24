require "../xq"

class Xq::CLI
  include Opts

  USAGE = <<-EOF
    Usage: {{program}} [options...] filter [file]

    Options:
    {{options}}

    Examples:
      (formatting)
        % cat foo.xml | {{program}} .
      (css filtering)
        % cat foo.xml | {{program}} .item  # => "<item>..."
    EOF

#  option strict  : Bool   , "-s"       , "Find tags strictly with xpath", false
  option ignore  : Bool   , "-i", "Ignore case distinctions like grep", false
  option version : Bool   , "--version", "Print the version and exit", false
  option help    : Bool   , "--help"   , "Output this help and exit" , false

  var buffer : String
  var filter : Xq::CssFilter

  def run
    xq = Xq::Plain.new(buffer)
    nodes = xq.css(filter)
    print(nodes)
  end

  private def setup
    self.exit(show_version) if version

    self.filter = css_filter(extract_filter!(args))
    self.buffer = ARGF.gets_to_end
  end

  private def extract_filter!(args) : String
    case args.size
    when 1,2
      return args.shift.not_nil!
    else
      abort show_usage
    end
  end

  private def css_filter(filter) : Xq::CssFilter
    name =
      case filter
      when /^\.$/     ; "*"
      when /^\.(.*)$/ ; $1
      else ; abort "expected css filter like '.foo', but got '#{filter}'"
      end
    Xq::CssFilter.build(name, ignore: ignore)
  end

  private def print(nodes : Array(XML::Node))
    if nodes.first?.try(&.parent).try(&.document?)
      s = String.build do |io|
        nodes.each do |n|
          io << n.to_s
        end
      end
      puts XML.parse(s).to_xml
    else
      nodes.each do |n|
        puts n.to_xml
      end
    end
  end
end

Xq::CLI.run
