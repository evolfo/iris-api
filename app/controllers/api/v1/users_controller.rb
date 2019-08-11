class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:update]

  def index
    @users = User.all
    render json: @users
  end

  def create
  	@user = User.create(user_params)
  	if @user.valid?
  	  render json: { user: UserSerializer.new(@user) }, status: :created
  	else
  	  render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
  	end
  end
 
  def update
    @user.update(user_params)
    if @user.save
      render json: @user, status: :accepted
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
    end
  end
 
  private
 
  def user_params
    params.permit(:first_name, :last_name, :email, :phone, :billing_address, :zip_code, :fan_level, :tier)
  end
 
  def find_user
    @user = User.find(params[:id])
  end
end
