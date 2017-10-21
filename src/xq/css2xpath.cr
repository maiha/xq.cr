# https://github.com/madeindjs/Crystagiri/blob/master/src/crystagiri/html.cr
module Xq
  def self.css2xpath(query : String) : String
    query = "//#{query}"
    # Convert '#id_name' as '[@id="id_name"]'
    query = query.gsub /\#([A-z0-9]+-*_*)+/ { |m| "*[@id=\"%s\"]" % m.delete('#') }
    # Convert '.classname' as '[@class="classname"]'
    query = query.gsub /\.([A-z0-9]+-*_*)+/ { |m| "[@class=\"%s\"]" % m.delete('.') }
    # Convert ' > ' as '/'
    query = query.gsub /\s*>\s*/ { |m| "/" }
    # Convert ' ' as '//'
    query = query.gsub " ", "//"
    # a leading '*' when xpath does not include node name
    query = query.gsub /\/\[/ { |m| "/*[" }
    return query
  end
end
