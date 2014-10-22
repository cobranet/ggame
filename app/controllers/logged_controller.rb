class LoggedController < ApplicationController
  def show
  end
  def create
    gi = Gameinv.new
    gi.user_id = params[:id] 
    gi.save!
    render :json => gi
  end
  
end
