class LoggedController < ApplicationController
  def show
  end

  def create
    gi = Gameinv.new
    gi.user_id = params[:id] 
    gi.save!
    render :json => state_json
  end

  def join
    ginv = params[:ginvid].to_i
    gap = Gameapplication.new
    gap.user_id = current_user.id
    gap.gameinv_id = ginv
    gap.save!
    render :json => state_json
  end
  
  def state_json
    s = {}  
    s['games']= Gameinv.get_games
    s['user'] = current_user
    gi = Gameinv.where(user_id: current_user.id)
    applay = Gameinv.game_applay(current_user.id)
    if gi.length == 0 
      s['showCreate'] = true;
      s['showCancel'] = false;
      s['showApplay'] = false;
    else
      s['showCreate'] = false;
      s['showCancel'] = true;
      s['showApplay'] = false;
    end
    if applay != nil
      s['applay'] = applay
      s['showCreate'] = false;
      s['showCancel'] = false;
      s['showApplay'] = true;
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
