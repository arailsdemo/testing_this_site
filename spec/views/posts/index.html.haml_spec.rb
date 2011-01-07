require "spec_helper"

describe "posts/index.html.haml" do
  let(:post1) do
    mock_model('Post',
      :sequence => 1,
      :title => 'First Post',
      :description => 'Description1',
      :created_at => Time.utc(2000))
  end

  let(:post2) do
    mock_model('Post',
      :sequence => 2,
      :title => 'Second Post',
      :description => 'Description2',
      :created_at => Time.utc(2001))
  end

  context 'when an admin is not signed in' do
    before do
      view.stub(:admin?) { false }
    end

    context "and no posts are present" do
      before do
        assign :posts, []
        render
      end

      it "displays the title as an h1" do
        rendered.should have_selector 'h1',
          :content => 'Building This Site',
          :count => 1
      end

      %W(postShow sequence title date).each do |klass|
        it "does not display div with class '#{klass}'" do
          rendered.should_not have_selector 'div', :class => klass
        end
      end
    end
  end
end