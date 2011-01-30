require "spec_helper"

describe "/shared/_error_messages.html.haml" do
  context "given a valid post" do
    before do
      render :partial => 'shared/error_messages', :locals => { :target => post_stub }
    end

    it "does not render anything" do
      rendered.should be_blank
    end
  end

  context "given an invalid post" do
    before do
      post = post_stub(:errors => [1,1])
      post.stub_chain(:errors, :full_messages).and_return ['foo', 'bar']
      render :partial => 'shared/error_messages', :locals => { :target => post_stub }
    end

    it "displays the number of errors" do
      rendered.should have_selector 'h2' do |h2|
        h2.should contain '2 errors'
      end
    end

    it "displays each error" do
      rendered.should contain 'foo'
      rendered.should contain 'bar'
    end
  end
end
