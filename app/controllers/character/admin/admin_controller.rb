class Character::Admin::AdminController < ActionController::Base
  #include BrowserID::Rails::Base
  layout false

  def index
    authenticated?

    # grab editable models here
    @admin_models = ::Rails.application.config.character_admin_models.collect{ |name| name.constantize }

    render 'character/admin/index'
  end
end