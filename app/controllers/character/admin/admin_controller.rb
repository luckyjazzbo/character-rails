class Character::Admin::AdminController < ActionController::Base
  #include BrowserID::Rails::Base
  layout false

  def index
    authenticated?

    # grab editable models here
    @admin_models = Character::ModelAdmin.subclasses.map(&:name).uniq.collect{ |name| name.constantize }

    render 'character/admin/index'
  end
end