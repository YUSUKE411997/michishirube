class Users::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      redirect_back(fallback_location: root_path)
    else
      @post = Post.find_by(id: @comment.post_id)
      @comments = @post.comments
      render 'users/posts/show'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
