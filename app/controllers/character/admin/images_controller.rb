class Character::Admin::ImagesController < Character::Admin::BaseController
  def create
    @object = Character::Image.new

    @object.image = params[:image]
    
    if @object.save
      render json: @object
    else
      render nothing: true
    end
  end
end