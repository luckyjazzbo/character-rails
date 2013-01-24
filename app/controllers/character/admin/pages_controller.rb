class Character::Admin::PagesController < ApplicationController
  #before_filter :authenticate_admin_user!, except: [:home, :show]

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
