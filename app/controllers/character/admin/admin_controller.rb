class Character::Admin::AdminController < ActionController::Base
  #include BrowserID::Rails::Base
  layout false

  def index
    authenticated?

    # grab editable models here
    @admin_models = [Character::AdminUser, Project]
    #@admin_models.concat Character::ModelAdmin.subclasses.map(&:name).uniq.collect{ |name| name.constantize }
    #@admin_models.concat Character::ModelAdmin.descendants.map(&:name).collect{ |n| n.constantize }

    render 'character/admin/index'
  end
end