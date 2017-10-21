require "./spec_helper"

private def xq
  Xq::Plain.new(read_fixture("response.xml"))
end

describe Xq::Plain do
  describe "#css" do
    context "ns1:fieldName" do
      it "returns 1 field" do
        xq.css("ns1:fieldName").map(&.name).sort.uniq.should eq(["fieldName"])
      end
    end

    context "fieldName" do
      it "returns 1 field" do
        xq.css("fieldName").map(&.name).sort.uniq.should eq(["fieldName"])
      end
    end

    context "ns1:*Field*" do
      it "returns 3 fields" do
        xq.css("ns1:*Field*").map(&.name).sort.uniq.should eq(["displayFieldNameEN", "displayFieldNameJA", "getReportFieldsResponse"])
      end
    end

    context "*Field*" do
      it "returns 3 fields" do
        xq.css("*Field*").map(&.name).sort.uniq.should eq(["displayFieldNameEN", "displayFieldNameJA", "getReportFieldsResponse"])
      end
    end
  end
end
