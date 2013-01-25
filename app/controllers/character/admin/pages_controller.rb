class Character::Admin::PagesController < Character::Admin::ApplicationController
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
    Character::Page.reorder(params[:ids])
    render json: 'ok'
  end
end
