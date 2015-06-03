class UsersController < ApplicationController
  before_action :get_user, except:[:index]
  
  def edit
    
  end
  
  def get_user
    @user = User.find params[:id]
  end
end
