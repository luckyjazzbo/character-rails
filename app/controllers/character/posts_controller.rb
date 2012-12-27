class Character::PostsController < ApplicationController
  before_filter :authenticate_admin_user!
end