class Character::Admin::PostsController < Character::Admin::ApplicationController
  def index
    @posts = []
    @posts += Character::Post.drafts.to_a
    @posts += Character::Post.published.to_a
    render json: @posts
  end

  def create
    @post = Character::Post.create params[:post]
    render json: @post
  end

  def update
    @post = Character::Post.find(params[:id])
    @post.update_attributes params[:post]
    render json: @post
  end

  def destroy
    @post = Character::Post.find(params[:id])
    @post.destroy
    render json: 'ok'
  end
end