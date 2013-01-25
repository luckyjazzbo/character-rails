class Character::Admin::AdminController < ActionController::Base
  #include BrowserID::Rails::Base
  layout false

  def index
    authenticated?
  end
end