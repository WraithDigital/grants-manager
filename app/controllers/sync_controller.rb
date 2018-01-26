class SyncController < ApplicationController

  before_action :authorize_admin

  def grant
    grant = Grant.find(params[:id])

    return unprocessable unless current_user.can_sync_grant?(grant)

    SyncGrantJob.enqueue(grant.id)

    flash[:success] = 'Grant will be synced shortly'
    redirect_to grants_path
  end

end
