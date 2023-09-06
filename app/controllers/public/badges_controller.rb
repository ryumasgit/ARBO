class Public::BadgesController < ApplicationController
  before_action :authenticate_member!
  
  def index
  end
end
