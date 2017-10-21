require "./spec_helper"

describe Xq do
  describe ".new" do
    context "(option: namespace=true)" do
      it "returns Xq::XPath" do
        opt = Xq::Options.new.tap(&.namespace = true)
        Xq.new("<a/>", opt).should be_a(Xq::XPath)
      end
    end

    context "(otherwise)" do
      it "returns Xq::Plain" do
        Xq.new("<a/>").should be_a(Xq::Plain)
      end
    end
  end
end
