class Character::Admin::ImagesController < Character::Admin::BaseController
  def index
    @objects = Character::Image.all
    render :json => @objects
  end

  def create
    @object = Character::Image.new

    @object.src = params[:file]
    
    if @object.save
      render json: @object
    else
      render nothing: true
    end
  end
end