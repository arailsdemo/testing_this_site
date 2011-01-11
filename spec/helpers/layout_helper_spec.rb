require 'spec_helper'

describe LayoutHelper do
  describe "#title" do
    it "sets content_for(:title)" do
      helper.title 1
      helper.content_for(:title).should == '1'
    end
  end

  describe "#javascript" do
    it "adds to content_for(:head)" do
      helper.javascript "foo", "bar"
      helper.content_for(:head).should == javascript_include_tag("foo", "bar")
    end
  end
end
