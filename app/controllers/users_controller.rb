class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    ApplicationRecord.transaction do
      @user = User.new(user_params)
      @user.save!
      redirect_to [:users], notice: t('.notice')
    end
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = t('.alert')
    render :new
  end

  def update
    ApplicationRecord.transaction do
      @user = User.find(params[:id])
      @user.update!(user_params)
      redirect_to [:users], notice: t('.notice')
    end
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = t('.alert')
    render :edit
  end

  def destroy
    ApplicationRecord.transaction do
      @user = User.find(params[:id])
      @user.destroy!
      redirect_to [:users], notice: t('.notice')
    end
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = t('.alert')
    render :index
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :note
      )
  end
end
