class Character::ImagesController < ApplicationController
  before_filter :authenticate_admin_user!

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