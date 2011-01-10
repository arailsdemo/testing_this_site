require "spec_helper"

describe "/sections/_form_fields.html.haml" do
  before do
    form_for(post_stub) { |f| @f = f }
    render :partial => 'sections/form_fields', :locals => { :builder => @f }
  end

  it "has a heading text field" do
    rendered.should have_selector :input,
      :id => 'post_sections_attributes_0_heading'
  end
end