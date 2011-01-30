require 'spec_helper'

describe "posts/edit.html.haml" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "MyString",
      :description => "MyText",
      :sequence => 1,
      :status => "MyString"
    ))
  end

  it "renders the edit post form" do
    render
    rendered.should have_selector "form", :action => post_path(@post), :method => "post"
  end
end
