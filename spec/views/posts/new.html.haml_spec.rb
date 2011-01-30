require 'spec_helper'

describe "posts/new.html.haml" do
  before(:each) do
    assign(:post, stub_model(Post,
      :title => "MyString",
      :description => "MyText",
      :sequence => 1,
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new post form" do
    render
    rendered.should have_selector "form", :action => posts_path, :method => "post"
  end
end
