class ApplicationController < ActionController::Base


  def admin_url
    request .fullpath .include?("/admin")
  end


end
