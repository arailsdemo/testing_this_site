require "spec_helper"

describe "posts/_form.html.haml" do
  include Stubs

  before do
    view.stub :javascript
    stub_template "shared/_error_messages.html.haml" => 'error messages'
    stub_template "sections/_form_fields.html.haml" => "sections fields"
    assign :post, post_stub
  end

  it "calls #javascript" do
    view.should_receive(:javascript).with 'post'
    render
  end

  context do
    before do
      render
    end

    it "creates a multipart form" do
      rendered.should have_selector :form,
        :enctype => "multipart/form-data"
    end

    it "renders the error messages" do
      rendered.should contain 'error messages'
    end

    it "has a title text field" do
      rendered.should have_selector :input,
        :id => 'post_title',
        :type => 'text'
    end

    it "has a status select field" do
      rendered.should have_selector(:select) do |select_field|
        select_field.should have_selector :option,
          :content => 'pending'
        select_field.should have_selector :option,
          :content => 'published'
      end
    end

    it "has a sequence text field" do
      rendered.should have_selector :input,
        :id => 'post_sequence',
        :type => 'number'
    end

    it "has a description textarea" do
      rendered.should have_selector :textarea,
        :id => 'post_description'
    end

    it "has a submit button" do
      rendered.should have_selector :input,
        :id => 'post_submit'
    end

    it "renders the sections fields" do
      rendered.should contain 'sections fields'
    end
  end
end
