require "spec_helper"

describe "Meet Capybara (non admin).", :integration => true do
  context "He's crawling around our app." do
    let(:post1){ @post1 ||= Factory(:post) }
    let(:post2){ @post2 ||= Factory(:post) }

    before { post1; post2 }

  end
end
