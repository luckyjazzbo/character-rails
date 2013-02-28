class Character::Admin::AdminController < Character::Admin::BaseController
  layout false

  def index
    # grab editable models here
    @admin_models = ::Rails.application.config.character_admin_models.collect{ |name| name.constantize }

    render 'character/admin/index'
  end
end