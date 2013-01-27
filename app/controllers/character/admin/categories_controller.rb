class Character::Admin::CategoriesController < Character::Admin::BaseController
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

  def reorder
    Character::Category.reorder(params[:ids])
    render json: 'ok'
  end
end