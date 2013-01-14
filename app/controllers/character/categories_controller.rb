class Character::CategoriesController < ApplicationController
  before_filter :authenticate_admin_user!

  def index
    @objects = Character::Category.all
    render json: @objects
  end

  def create
    @object = Character::Category.create params[:category]
    render json: @object
  end

  def update
    @object = Character::Category.find(params[:id])
    @object.update_attributes params[:post]
    render json: @object
  end

  def destroy
    @object = Character::Category.find(params[:id])
    @object.destroy
    render json: 'ok'
  end
end