class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    @range = params[:range]
    if @range == "投稿"
      @posts = Post.search(params[:word])
    else
      @users = User.search(params[:word])
    end
  end
end
