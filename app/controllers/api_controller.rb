require 'csv'

class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate

  before_action :authorize, only: [:import]

  def import
    data = CSV.parse(params[:csv])
    data.shift

    data.each do |grant|
      begin
        unless Grant.find_by(url: grant[2])
          Grant.create!(
            user_id: get_user(grant[0]),
            agency: Agency.find_by!(shortname: grant[1]),
            url: grant[2],
            body: ''
          )
        end
      rescue => e
        return render json: {
          message: "ERROR IMPORTING GRANT ROW: #{grant.inspect}, ERROR: #{e}"
        }, status: 422
      end
    end

    head :ok
  end

  def validate
    if Grant.find_by(url: validate_params[:url])
      render json: {status: 'exists', message: 'url already exists'}, status: 200
    else
      render json: {status: 'available'}, status: 200
    end
  end

  private

  def validate_params
    params.require(:grant).permit(:url)
  end

  def authorize
    return unauthorized unless request.headers['Authorization'] == Settings.api.key
  end

  def get_user(email)
    users = User.where(admin: false)
    if email.present?
      users.find_by(email: email).try(:id)
    else
      users.pluck(:id).sample
    end
  end

end
