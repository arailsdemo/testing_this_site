require "spec_helper"

Scenario "Capybara is now an admin.", :js => true do
  Given "he's at the post index page," do
    let(:post1){ @post1 ||= Factory(:post) }
    let(:post2){ @post2 ||= Factory(:post) }

    before do
      post1; post2
      sign_in_admin
      visit '/posts'
    end

    Then "he can delete the post" do
      page.evaluate_script('window.confirm = function() { return true; }')
      click_link 'Destroy'
      page.should have_no_content post1.title
    end

    Or "he can delete the post, but choose not to" do
      page.evaluate_script('window.confirm = function() { return false; }')
      click_link 'Destroy'
      page.should have_content post1.title
      page.should have_link 'Destroy', :count => 2
    end
  end
end
