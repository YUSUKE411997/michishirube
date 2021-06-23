class Plan < ApplicationRecord

  belongs_to :user
  belongs_to :post

  # やってみたい投稿の場合はカレンダー内で登録する為、一時保存
  def self.create_plan(current_user, post)
    case post.type
    when "やってみたいを投稿"
      Plan.create(user_id: current_user.id, post_id: post.id)
    when "やってみたを投稿"
      Plan.create(user_id: current_user.id, post_id: post.id, start_time: post.created_at)
    end
  end
  
end
