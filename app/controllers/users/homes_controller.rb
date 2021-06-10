class Users::HomesController < ApplicationController

  def top
    @lanks_0 = Post.create_ranks(0)
    @lanks_1 = Post.create_ranks(1)
    @lanks_2 = Post.create_ranks(2)
  end

end
