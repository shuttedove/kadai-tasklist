class ToppagesController < ApplicationController
  def index
    if (logged_in?)
       @task = current_user.tasks      
    end
  end
end
