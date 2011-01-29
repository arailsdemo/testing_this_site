require "spec_helper"

Scenario "Meet Capybara (non admin).", :integration => true do
  Given "He's crawling around our app." do
    let(:post1){ @post1 ||= Factory(:post) }
    let(:post2){ @post2 ||= Factory(:post) }

    before { post1; post2 }

    When "he visits the post index page," do
      before { visit posts_url }

      Then "he should see a listing of post titles" do
        page.should have_content post1.title
        page.should have_content post2.title
      end

      And_ "the posts should be in div.postShow" do
        within(:xpath, '//div[@class="postShow"][1]') do
          page.should have_content(post1.title)
        end

        within("div.postShow[2]") do
          page.should have_content(post2.title)
        end
      end

      When "Capybara clicks on the 'Show' link for the first post," do
        before do
          find(:xpath, "//a[@href=\'#{post_path(post1.sequence)}\']").click
        end

        Then "he should see the show page" do
          save_and_open_page
          page.should have_content post1.title
          current_path.should == "/posts/#{post1.sequence}"
        end

        And_ "he shouldn't see an edit link" do
          page.should have_no_selector 'a', :text => 'Edit'
        end
      end
    end
  end
end
