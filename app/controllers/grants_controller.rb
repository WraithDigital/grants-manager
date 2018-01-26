class GrantsController < ApplicationController

  before_action :authorize_admin,      only: [:new, :create]
  before_action :find_grant,           only: [:edit, :update]
  before_action :initialize_countries, except: [:home, :index]

  def home
    redirect_to grants_path
  end

  def index
    @synced = params[:synced]
    @limit = params[:limit] || Grant.per_page
    @grants = Grant.order(created_at: :desc).includes(:user, :agency, :review)
    @grants = @grants.where(user: current_user) unless current_user.admin?
    # TODO refactor these filter conditionals
    if params[:synced] == 'synced'
      @grants = @grants.where(dirty: false)
    elsif params[:synced] == 'unsynced'
      @grants = @grants.where(dirty: true)
    end
    @grants = @grants.page(params[:page]).per(@limit)
  end

  def new
    @grant = current_user.grants.new
  end

  def create
    @iso_country_codes = IsoCountryCodes.all

    begin
      ActiveRecord::Base.transaction do
        @grant = Grant.create!(modified_grant_params)

        params[:grant][:applicant_type].reject(&:blank?).split(',').each do |id|
          @grant.applicant_types << ApplicantType.find(id)
        end

        create_deadlines(@grant)

        flash[:success] = 'Grant created successfully'
        redirect_to grants_path
      end
    rescue
      flash[:error] = 'There was a problem saving, please fill in all required fields.'
      redirect_to new_grant_path
    end
  end

  def edit
    @preview = CustomMarkdown.new.render(@grant.body)
  end

  def update
    return unauthorized unless current_user.can_update_grant?(@grant)
    begin
      ActiveRecord::Base.transaction do
        @grant.update_attributes(update_grant_params)

        params[:grant][:applicant_type].reject(&:blank?).split(',').each do |id|
          type = ApplicantType.find(id)
          if type
            @grant.applicant_types = type
          end
        end

        @grant.deadlines.destroy_all # TODO use hidden field to update the deadline instead of destroy
        create_deadlines(@grant)

        flash.now[:success] = 'Grant updated successfully'
      end
    rescue
      flash.now[:error] = 'Something went wrong'
    end

    @preview = CustomMarkdown.new.render(@grant.body)
    redirect_to edit_grant_path(@grant)
  end

  private

  def find_grant
    @grant = Grant.all
    @grant = @grant.where(user: current_user) unless current_user.admin?
    @grant = @grant.find(params[:id])
  end

  def create_deadlines(grant)
    params[:deadline].each do |k,v|
      if v[:notes].present?
        Deadline.create!(
          grant_id:  grant.id,
          date:     v[:date].try(:to_time).try(:utc),
          item_due: v[:item_due],
          notes:    v[:notes]
        )
      end
    end
  end

  def initialize_countries
    require './lib/countries'
    @iso_country_codes = Countries.list
  end

  def admin_grant_params
    params.require(:grant).permit(:user_id, :agency_id, :title, :url, :amount, :time_zone, :sponsor, :body, :residency => [], :activity_location => [])
  end

  def grant_params
    params.require(:grant).permit(:agency_id, :title, :url, :amount, :time_zone, :sponsor, :body, :residency => [], :activity_location => [])
  end

  def update_grant_params
    modified_grant_params.merge(dirty: true)
  end

  def modified_grant_params
    if current_user.admin
      gp = admin_grant_params
    else
      gp = grant_params
    end
    gp[:activity_location] = params[:grant][:activity_location].reject(&:blank?).join(",")
    gp[:residency] = params[:grant][:residency].reject(&:blank?).join(",")
    gp
  end

end
