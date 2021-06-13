module ApplicationHelper

  def post_created(post)
    post.created_at.strftime("%Y/%m/%d %H:%M")
  end

  def comment_created(comment)
    comment.created_at.strftime("%Y/%m/%d %H:%M")
  end

  def message_created(message)
    message.created_at.strftime("%Y/%m/%d %H:%M")
  end
  
end
