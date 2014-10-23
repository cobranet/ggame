class LoggedController < ApplicationController
  def show
  end

  def create
    gi = Gameinv.new
    gi.user_id = params[:id] 
    gi.save!
    FayeRails::Controller.publish("/allwaiting",{message: 'nesto'})    
    render :json => state_json
  
  end

  def join
    ginv = params[:ginvid].to_i
    user = User.find(Gameinv.find(ginv).user_id)
    gap = Gameapplication.new
    gap.state = 0
    gap.user_id = current_user.id
    gap.gameinv_id = ginv
    gap.save!
    FayeRails::Controller.publish("/chat/#{user.id}",{message: 'nesto'})    
    render :json => state_json
   end
  

  def accept_player
    gap = params[:gameapp].to_i
    ga = Gameapplication.find(gap) 
    ga.state = 1
    ga.save!
    Gameapplication.where(gameinv_id: ga.gameinv_id).each do |app|
      FayeRails::Controller.publish("/chat/#{app.user_id}",{message: 'nesto'})    
    end  
    render :json => state_json
  end

  def reject_player
    gap = params[:gameapp].to_i
    ga = Gameapplication.find(gap) 
    ginv = Gameinv.find(ga.gameinv_id)
    Gameapplication.where(gameinv_id: ga.gameinv_id).each do |app| 
      FayeRails::Controller.publish("/chat/#{app.user_id}",{message: 'nesto'})    
    end
    Gameapplication.delete(gap)
    render :json => state_json
  end

  def cancel_waiting
    gap = params[:gameapp]
    ga = Gameapplication.find(gap) 
    ginv = Gameinv.find(ga.gameinv_id)
    user = User.find(Gameinv.find(ginv).user_id)
    Gameapplication.delete(gap)
    FayeRails::Controller.publish("/chat/#{user.id}",{message: 'nesto'})    
    render :json => state_json
  end

  def state_json
    s = {}  
    s['games']= Gameinv.get_games
    s['user'] = current_user
    gi = Gameinv.where(user_id: current_user.id).first
    if gi
      s['applicants'] = Gameinv.applicants(gi.id)
      s['gameinv_id'] = gi.id
    end
    applay = Gameinv.game_applay(current_user.id)
    puts "###################################################"
    puts applay.inspect
    if applay
      puts applay[:gameinv_id] 
      s['applicants'] = Gameinv.applicants(applay[:gameinv_id])
    end
    puts "###################################################"
    if gi == nil
      s['showCreate'] = true;
      s['showCancel'] = false;
      s['showApplicants'] = false;
      s['showGameState'] = false;
    else
      s['showCreate'] = false;
      s['showCancel'] = true;
      s['showApplicants'] = true;
      s['showGameState'] = false;
    end
    if applay != nil
      s['applay'] = applay
      s['showCreate'] = false;
      s['showCancel'] = false;
      s['showApplicants'] = false;
      s['showGameState'] = true;
    end  
    s  
  end
  
  def state
    render :json => state_json
  end
  
  def cancel 
    gameinv_id = params[:gameinv_id].to_i
    Gameinv.where(id: gameinv_id).destroy_all
    Gameapplication.where(gameinv_id: gameinv_id).each do |app|
      puts "cance"
      puts app.id
      puts "###########################################"
      FayeRails::Controller.publish("/chat/#{app.user_id}",{message: 'nesto'})    
      Gameapplication.delete(app.id)
    end
    FayeRails::Controller.publish("/allwaiting",{message: 'nesto'})    
    render :json => state_json
  end  
end
