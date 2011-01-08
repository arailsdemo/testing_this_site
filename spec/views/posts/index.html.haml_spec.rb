require "spec_helper"

def post1_displayed_attributes
  {
    :sequence => 1,
    :title => 'First Post',
    :date => "January 01, 2000"
  }
end

def post2_displayed_attributes
  {
    :sequence => 2,
    :title => 'Second Post',
    :date => "January 01, 2001"
  }
end

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

    context "and two posts are present" do
      before do
        assign :posts, [post1, post2]
        render
      end

      [post1_displayed_attributes, post2_displayed_attributes].each do |hash|
        hash.each_pair do |attribute, value|
          it "displays div.#{attribute} with '#{value}'" do
            rendered.should have_selector 'div > div',
              :class => attribute.to_s,
              :content => value.to_s
          end
        end
      end

      it "does not have a delete link" do
        rendered.should_not have_selector 'a',
          :"data-method" => "delete"
      end

      it "does not have a new link" do
        rendered.should_not have_selector 'a',
          :href => new_post_path
      end
    end
  end

  context "when an admin is signed in and there is one post" do
    before do
      view.stub(:admin?) { true }
      assign :posts, [post1]
      render
    end

    it "has an edit link for that post inside .admin" do
      rendered.should have_selector 'a',
        :href => edit_post_path(post1.sequence),
        :content => 'Edit'
    end

    it "has a destroy link for that post inside .admin" do
      rendered.should have_selector('.postShow > .admin') do |admin_div|
        admin_div.should have_selector 'a',
          :href => post_url(post1.sequence),
          :"data-method" => "delete",
          :content => 'Destroy'
      end
    end

    it "has a new link" do
      rendered.should have_selector 'a',
        :href => new_post_path,
        :content => 'New'
    end
  end
end