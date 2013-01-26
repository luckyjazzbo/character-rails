class Character::Admin::AdminController < ActionController::Base
  #include BrowserID::Rails::Base
  layout false

  def index
    authenticated?

    render 'character/admin'
  end
end