require "spec_helper"

describe "/sections/_form_fields.html.haml" do
  before do
    form_for(post_stub) { |f| @f = f }
    stub_template 'snippets/_form_fields.html.haml' => 'snippets fields'
    render :partial => 'sections/form_fields', :locals => { :builder => @f }
  end

  it "has a heading text field" do
    rendered.should have_selector :input,
      :id => 'post_sections_attributes_0_heading'
  end

  it "has a body textarea" do
    rendered.should have_selector :textarea,
      :id => 'post_sections_attributes_0_body'
  end

  it "has a position text field" do
    rendered.should have_selector :input,
      :id => 'post_sections_attributes_0_position'
  end

  it "renders the snippets fields" do
    rendered.should contain 'snippets fields'
  end
end