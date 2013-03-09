class Character::Admin::AdminController < Character::Admin::BaseController
  layout false

  def index
    # grab editable models here
    @admin_models = ::Rails.application.config.character_admin_models.reject do |name|
      ['Character::Post', 'Character::Page'].include? name
    end.collect{ |name| name.constantize }

    render 'character/admin/index'
  end
end