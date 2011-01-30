require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "works! (now write some real specs)" do
      sign_in_admin
      get posts_path
      response.status.should be(200)
    end
  end
end
