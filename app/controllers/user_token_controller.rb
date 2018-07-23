class UserTokenController < ApplicationController
  def create
    data = ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    Rails.logger.error params.to_yaml
    
    # user = User.where(full_name: data[:full_name]).first
    user = User.find_by(email: data[:email])


    head 406 and return unless user
    if user.authenticate(data[:password])
      user.regenerate_token
      render json: user, status: :created,
             serializer: ActiveModel::Serializer::SessionSerializer and return
    end
    head 403
  end

  def destroy
    user = User.where(token: params[:id]).first
    head 404 and return unless user
    user.regenerate_token
    head 204
  end
end