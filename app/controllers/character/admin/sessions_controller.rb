class Character::Admin::SessionsController < ActionController::Base
  #include BrowserID::Rails::Base

  # POST /login
  def create
    respond_to_browserid
  end

  # POST /logout
  def destroy
    logout_browserid
    head :ok
  end
end