class Character::PagesController < ApplicationController
  before_filter :authenticate_admin_user!, except: [:home, :show]

  def index
    @pages = Character::Page.all
    render json: @pages
  end

  def create
    @page = Character::Page.create params[:page]
    render json: @page
  end

  def update
    @page = Character::Page.find(params[:id])
    @page.update_attributes params[:page]
    render json: @page
  end

  def destroy
    @page = Character::Page.find(params[:id])
    @page.destroy
    render json: 'ok'
  end

  def reorder
    Character::Page.reorder_objects(params[:ids])
    render json: 'ok'
  end

  # public

  def root
    @page = Character::Page.where(permalink:'/').first()

    if @page
      @menu_pages     = Character::Page.published.all.to_a
      @page_position  = @page._position

      render 'show'
    else
      render text: 'Home page is not set.'
    end
  end

  def show
    permalink = request.path

    @page = Character::Page.where(permalink:permalink).first()

    if @page
      @menu_pages     = Character::Page.published.all.to_a
      @page_position  = @page._position
    else
      raise ActionController::RoutingError.new('Page Not Found')
    end
  end
end
