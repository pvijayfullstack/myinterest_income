class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  #Works with the User table as part of Authlogic
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      #redirect_to root_url
      redirect_to customers_path
    else
      render :action => 'new'
    end
  end

  def destroy
    #probably just gets to the first one here
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

end
