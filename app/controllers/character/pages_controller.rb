class Character::PagesController < ApplicationController
  def root
    @page = Character::Page.where(permalink:'/').first()

    if @page
      @menu_pages     = Character::Page.published.all.to_a
      @page_position  = @page._position

      render 'show'
    else
      render text: 'Root page is not set.'
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