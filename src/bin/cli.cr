require "../xq"

class CLI
  include Opts

  USAGE = <<-EOF
    Usage: {{program}} [options...] filter [file]

    Options:
    {{options}}

    Examples:
      (formatting)
        % cat foo.xml | {{program}} .
    EOF

  option version : Bool   , "--version", "Print the version and exit", false
  option help    : Bool   , "--help"   , "Output this help and exit" , false

  def run
    case args.size
    when 0
      abort show_usage
    when 1
      pattern = args.shift
      buf     = ARGF.gets_to_end
      print Xq.new(buf).execute(pattern)
    when 2
      pattern = args.shift
      buf = File.read(args.shift)
      print Xq.new(buf).execute(pattern)
    else
      abort show_usage
    end
  end
end

CLI.run
