class Users::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find_by(id: @comment.post_id)
    @comments = @post.comments
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
    else
      render 'users/posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id]).destroy
    @post = Post.find_by(id: @comment.post_id)
    @comments = @post.comments
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
