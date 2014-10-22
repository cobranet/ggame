class LoggedController < ApplicationController
  def show
  end

  def create
    gi = Gameinv.new
    gi.user_id = params[:id] 
    gi.save!
    render :json => state_json
  end

  def state_json
    s = {}  
    s['user'] = current_user
    gi = Gameinv.where(user_id: current_user.id)
    if gi.length == 0
      s['showCreate'] = true;
      s['showCancel'] = false;
    else
      s['showCreate'] = false;
      s['showCancel'] = true;
    end
    s
  end
  def state
    render :json => state_json
  end
  def cancel 
    Gameinv.where(user_id: current_user.id).destroy_all
    render :json => state_json
  end  
end
