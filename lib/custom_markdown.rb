class CustomMarkdown

  def initialize
    @renderer = Redcarpet::Render::HTML.new(
      filter_html: true,
      safe_links_only: true,
      link_attributes: {target: '_blank'}
    )
  end

  def render(markdown)
    Redcarpet::Markdown
      .new(@renderer, {autolink: true, tables: true})
      .render(markdown)
  end

end
