class AgenciesController < ApplicationController

  before_action :authorize_admin

  def index
    @agencies = Agency.order(name: :asc)
  end

  def new
    @agency = Agency.new
  end

  def create
    @agency = Agency.new(admin_agency_params)
    if @agency.save
      flash[:success] = 'Agency created successfully'
      redirect_to agencies_path
    else
      flash.now[:error] = @agency.errors.full_messages.first
      render :new
    end
  end

  def edit
    @agency = Agency.find(params[:id])
  end

  def update
    @agency = Agency.find(params[:id])
    if @agency.update_attributes(admin_agency_params)
      flash.now[:success] = 'Agency updated successfully'
    else
      flash.now[:error] = @agency.errors.full_messages.first
    end
    render :edit
  end

  private

  def admin_agency_params
    params.require(:agency).permit(:name, :shortname)
  end

end
