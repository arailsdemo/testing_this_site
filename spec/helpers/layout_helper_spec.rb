require 'spec_helper'

describe LayoutHelper do
  describe "#title" do
    it "sets content_for(:title)" do
      helper.title 1
      helper.content_for(:title).should == '1'
    end
  end
end
