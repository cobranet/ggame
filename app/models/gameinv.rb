class Gameinv < ActiveRecord::Base
  def self.get_games
    r = [] 
    Gameinv.all.each do |ginv|
      u = User.find(ginv.user_id) 
      r << { id: ginv.id,
             name: u.name,
             image: u.image } 
    end
    r
  end
  
  def self.game_applay(user_id)
    a = Gameapplication.where(user_id: user_id).first
    if a == nil
      b = nil
    else
      ginv = Gameinv.find(a.gameinv_id)
      user = User.find(ginv.user_id) 
      b = { gapid: a.id,
            gameinv_id: ginv.id,
            name: user.name,
            image: user.image }
    end
    b 
  end
end
