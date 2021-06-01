module ApplicationHelper

  def post_created(post)
    post.created_at.strftime("%Y-%m-%d %H:%M")
  end
end
