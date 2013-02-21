class Character::PostsController < ApplicationController
  before_filter :load_all_categories

  def load_all_categories
    @categories = Character::Category.all
  end

  def index
    @posts = Character::Post.published
    #@posts = @posts.page params[:page]
  end

  def category
    @category = Character::Category.find(params[:slug])
    @posts    = @category.posts.published
    #@posts    = @posts.page params[:page]
    render 'index'
  end  

  def show
    @post = Character::Post.published.find_by(slug:params[:slug])
  end

  def feed
    @posts = Character::Post.unscoped.order_by(:date.desc).published

    respond_to do |format|
      format.rss { render :layout => false }
      format.all { head :not_found }
    end
  end
end