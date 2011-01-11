require "spec_helper"

describe PostsHelper do
  describe "#post_date" do
    it "returns a formatted created_at date if published_at not present" do
      post_stub(:created_at => Time.utc(2000))
      helper.post_date(post_stub).should == "January 01, 2000"
    end

    it "returns a formatted published_at date if present" do
      post_stub(:created_at => Time.utc(2000), :published_at => Time.utc(2001))
      helper.post_date(post_stub).should == "January 01, 2001"
    end
  end

  describe "#sequence_display" do
    it "returns an image tag if pending" do
      helper.stub(:image_tag) { 'image' }
      post_stub(:status => 'pending')
      helper.sequence_display(post_stub).should == 'image'
    end

    it "returns the sequence if not pending" do
      post_stub(:status => 'published', :sequence => 42)
      helper.sequence_display(post_stub).should match '42'
    end
  end

  describe "#post_title" do
    it "returns the title as a link if published" do
      post_stub(:status => 'published')
      helper.post_title(post_stub).should == link_to(post_stub.title, post_url(post_stub.sequence))
    end

    context "when the post is pending" do
      it "returns the title that is not a link if not admin" do
        helper.stub(:admin?) { false }
        helper.post_title(post_stub).should_not match /href/
        helper.post_title(post_stub).should match post_stub.title
      end

      it "returns the title as a link if admin" do
        helper.stub(:admin?) { true }
        helper.post_title(post_stub).should == link_to(post_stub.title, post_url(post_stub.sequence))
      end
    end
  end
end