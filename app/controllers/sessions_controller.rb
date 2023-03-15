class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to root_path
    else
    # If user's login doesn't work, send them back to the login form.
      flash[:danger] = 'Invalid email/password combination, please retry.'
      redirect_to login_path
    end
  end

  def destroy
    # session[:user_id] = nil
    # Better solution from the tutorial comments section
    session.delete(:user_id)
    redirect_to login_path
  end
  
end
