class Users::SearchesController < ApplicationController

  def search
    @word = params[:word]
    @posts = Post.includes(:user, :comments, :likes).search(params[:word]).page(params[:page]).order(created_at: :desc)
    if @word == ""
      redirect_back(fallback_location: root_path)
    end
  end
end