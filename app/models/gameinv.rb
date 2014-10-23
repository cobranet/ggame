class Gameinv < ActiveRecord::Base
  belongs_to :user
  has_many :gameapplications
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
  def self.applicants(gameinv_id) 
     r = []
     Gameapplication.where(gameinv_id: gameinv_id).each do |gap|
       user = User.find(gap.user_id)
       ginv = Gameinv.find(gap.gameinv_id)
       r << { id: gap.id,
             owner_id: ginv.user_id,
             user_id: gap.user_id,
             name: user.name,
             image: user.image,
             state: gap.state}
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
            image: user.image,
            state: a.state}
    end
    b 
  end
end
