require 'spec_helper'

describe "posts/show.html.haml" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "Title",
      :description => "MyText",
      :sequence => 1,
      :status => "Status"
    ))
  end

  context "non admin" do
    before { view.stub(:admin?).and_return(false) }

    it "does not show an Edit link" do
      render
      rendered.should_not contain 'Edit'
    end
  end
end
