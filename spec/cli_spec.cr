require "./spec_helper"

private macro it_run(command, expected)
  it {{command}} do
    Dir.mkdir_p("tmp")
    File.write("tmp/aho.xml", "<a><b>xxx</b></a>")
    `{{command.id}} 2>&1`.chomp.should eq({{expected}})
  end
end

describe "cli" do
  it_run "cat tmp/aho.xml | ./xq .", <<-EOF
    <?xml version="1.0"?>
    <a>
      <b>xxx</b>
    </a>
    EOF

  it_run "cat tmp/aho.xml | ./xq .b", <<-EOF
    <b>xxx</b>
    EOF
end
