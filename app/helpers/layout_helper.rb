module LayoutHelper
  def title(page_title)
    content_for(:title) { page_title.to_s }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
end
