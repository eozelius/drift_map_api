class UsersController < ApplicationController
  before_action :authenticate_user, only: [:update, :destroy]
  skip_before_action :validate_type, only: [:show]

  def show
    user = User.find(params[:id])
    render json: user, include: ['driftmap']
  end

  def create
    user = User.new(user_params)
    
    if user.save
      render json: user, status: :created
    else
      render_error(user, :unprocessable_entity)
    end
  end

  def update
    if @user.update_attributes(user_params)
      render json: @user, status: :ok
    else
      render_error(@user, :unprocessable_entity)
    end
  end

  def destroy
    @user.destroy
    head 204
  end

  private

  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end