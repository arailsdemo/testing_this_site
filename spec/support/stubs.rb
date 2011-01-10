module Stubs
  def post_stub(stubs={})
    defaults = {
      :sequence => 1,
      :title => 'First Post',
      :description => 'Description1',
      :status => 'pending',
      :created_at => Time.utc(2000),
      :sections => [stub_model(Section)]
    }
    @post_stub ||= stub_model(Post, defaults.merge(stubs))
  end
end
