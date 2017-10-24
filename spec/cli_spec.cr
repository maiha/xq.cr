require "./spec_helper"

private macro it_run(command, expected)
  it {{command}} do
    Dir.mkdir_p("tmp")
    File.write("tmp/aho.xml", "<ul><li>foo</li><li>bar</li></ul>")
    `{{command.id}} 2>&1`.chomp.should eq({{expected}})
  end
end

describe "cli" do
  it_run "cat tmp/aho.xml | ./xq .", <<-EOF
    <?xml version="1.0"?>
    <ul>
      <li>foo</li>
      <li>bar</li>
    </ul>
    EOF

  it_run "cat tmp/aho.xml | ./xq .li", <<-EOF
    <li>foo</li>
    <li>bar</li>
    EOF

  it_run "cat tmp/aho.xml | ./xq .LI", ""

  it_run "cat tmp/aho.xml | ./xq -i .LI", <<-EOF
    <li>foo</li>
    <li>bar</li>
    EOF
end
