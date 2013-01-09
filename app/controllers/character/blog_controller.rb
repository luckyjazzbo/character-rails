class Character::BlogController < ApplicationController
  def index
    @posts = Character::Post.published
  end

  def show
    @post = Character::Post.published.find_by(slug:params[:slug])
  end
end