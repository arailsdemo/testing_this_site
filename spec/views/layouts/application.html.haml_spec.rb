require "spec_helper"

describe "layouts/application.html.haml" do
  before do
    stub_template "shared/_side_bar.html.haml" => 'sidebar template'
  end

  it "renders the sidebar" do
    render
    rendered.should contain 'sidebar template'
  end

  it "has a default title" do
    render
    rendered.should have_selector :title,
      :content => 'aRailsDemo'
  end

  context "using content_for(:title)" do
    let(:page_title) { "Building This Site" }

    before do
      view.content_for(:title) { page_title }
      render
    end

    it "sets <title>" do
      rendered.should have_selector :title,
        :content => "aRailsDemo | #{page_title}"
    end

    it "sets <h1>" do
      rendered.should have_selector :h1,
        :content => page_title
    end
  end
end