class ReviewsController < ApplicationController

  def index
    @reviews = Review.all.includes(:grant).order(created_at: :desc)
  end

  def show
    @review = Review.find(params[:id])
    @preview = CustomMarkdown.new.render(@review.grant.body)
  end

  def create
    # Handles both submissions and resubmissions via first_or_initialize
    grant = current_user.grants.find(params[:grant_id])
    review = current_user.reviews.where(grant: grant).first_or_initialize
    return unprocessable unless current_user.can_submit_review?(review)
    review.status = 'pending'
    review.save
    flash[:success] = 'Successfully submitted for review'
    redirect_to grants_path
  end

  def approve
    review = Review.find(params[:id])
    return unprocessable unless current_user.can_approve_review?(review)
    review.update_attributes!(status: 'approved')
    SyncGrantJob.enqueue(review.grant.id)
    flash[:success] = 'Review has been approved'
    redirect_to reviews_path
  end

  def reject
    review = Review.find(params[:id])
    return unprocessable unless current_user.can_approve_review?(review)
    review.update_attributes!(
      status: 'rejected',
      reviewer_notes: params[:reviewer_notes]
    )
    flash[:success] = 'Review has been rejected'
    redirect_to reviews_path
  end

end
