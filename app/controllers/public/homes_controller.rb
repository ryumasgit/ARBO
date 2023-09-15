class Public::HomesController < ApplicationController
  before_action :authenticate_member!, only: [:welcome]

  def top
  end

  def welcome
  end
end