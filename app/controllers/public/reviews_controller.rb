class Public::ReviewsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member,  except: [:show, :index]

  def new
  end

  def create
  end

  def show
  end

  def index
    members = Member.where(is_active: true)
    @reviews = members.first.reviews
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def ensure_correct_member
    @member = Member.find_by(member_name: params[:member_member_name])
    unless @member == current_member
    redirect_to reviews_path
    end
  end
end
