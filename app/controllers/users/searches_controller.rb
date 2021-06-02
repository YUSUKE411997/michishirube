class Users::SearchesController < ApplicationController

  def search
    @word = params[:word]
    @posts = Post.search(params[:word]).order(created_at: :desc)
  end
end
