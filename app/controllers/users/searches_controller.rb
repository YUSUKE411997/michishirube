class Users::SearchesController < ApplicationController

  def search
    @word = params[:word]
    @posts = Post.search(params[:word]).page(params[:page]).order(created_at: :desc)
  end
end
