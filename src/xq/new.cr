module Xq
  def self.new(string : String, options : Options? = nil)
    options ||= Options.new

    if options.namespace
      Xq::XPath.new(string, options)
    else
      Xq::Plain.new(string, options)
    end
  end
end
