class Users::SearchesController < ApplicationController

  def search
    @word = params[:word]
    @posts = Post.search(params[:word])
  end
end
