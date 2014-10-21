class WelcomeController < ApplicationController
  def index
    if current_user 
      redirect_to "/logged/#{current_user.id}"
    end
  end
end
