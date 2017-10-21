require "./spec_helper"

private def xq
  Xq::XPath.new(read_fixture("response.xml"))
end

describe Xq::XPath do
  describe "#css" do
    context "ns1:fieldName" do
      it "returns 2 nodes" do
        xq.css("ns1:fieldName").map(&.text).sort.should eq(["ADGROUP_ID","CAMPAIGN_ID"])
      end
    end
  end
end
