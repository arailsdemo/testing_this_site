module PostsHelper
  def post_date(post)
    date = post.published_at ? post.published_at : post.created_at
    l date, :format => :date
  end

  def sequence_display(post)
    post.pending? ? image_tag('cone.jpeg',
      :title => 'Post Under Construction') : "##{post.sequence.to_s}"
  end

  def post_title(post)
    post.pending? && !admin? ? post.title + " (Under Construction)" : link_to(post.title, post_url(post.sequence))
  end
end