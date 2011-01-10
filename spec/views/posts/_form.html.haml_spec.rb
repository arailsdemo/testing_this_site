require "spec_helper"

describe "posts/_form.html.haml" do
  let(:new_post) { mock_model('Post').as_new_record.as_null_object }

  context "given a new post object" do
    before do
      assign :post, new_post
    end

    it "creates a form" do
      view.should_receive(:form_for).with new_post
      render
    end

    it "has a title text field" do
      render
      rendered.should have_selector :input,
        :type => 'text',
        :name => 'post[title]'
    end
  end
end

=begin
describe "posts/_form.html.haml" do
  let(:existing_post) { mock_model('Post').as_null_object }
  let(:new_post) { mock_model('Post').as_new_record.as_null_object }

  it "can render a 'create' form" do
    assign :post, new_post
    render
    rendered.should have_selector 'form',
      :method => 'post',
      :action => posts_path
  end

  it "can render an 'update' form" do
    assign :post, existing_post
    render
    rendered.should have_selector 'form',
      :method => 'post',
      :action => post_path(existing_post)
  end

  context "given a new post object" do
    before do
      assign :post, new_post
    end

    it "creates a form" do
      view.should_receive(:form_for).with new_post
      render
    end

    it "has a title text field" do
      render
      rendered.should have_selector :input,
        :type => 'text',
        :name => 'post[title]'
    end
  end
end
=end