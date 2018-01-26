module ApplicationHelper

  def review_count
    @review_count ||= Review.where(status: 'pending').count
  end

  def wip_marker
    content_tag(:span, '&mdash;'.html_safe, class: 'faded')
  end

end
