class ApplicantTypesController < ApplicationController

  before_action :authorize_admin

  def index
    @applicant_types = ApplicantType.all
  end

  def new
    @applicant_type = ApplicantType.new
  end

  def create
    @applicant_type = ApplicantType.new(applicant_type_params)
    if @applicant_type.save
      flash[:success] = 'Applicant type created successfully'
      redirect_to applicant_types_path
    else
      flash.now[:error] = @applicant_type.errors.full_messages.first
      render :new
    end
  end

  def edit
    @applicant_type = ApplicantType.find(params[:id])
  end

  def update
    @applicant_type = ApplicantType.find(params[:id])
    if @applicant_type.update_attributes(applicant_type_params)
      flash.now[:success] = 'Applicant type updated successfully'
    else
      flash.now[:error] = @applicant_type.errors.full_messages.first
    end
    render :edit
  end

  private

  def applicant_type_params
    params.require(:applicant_type).permit(:name)
  end

end
