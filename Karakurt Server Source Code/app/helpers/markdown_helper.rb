require 'redcarpet'

module MarkdownHelper
  def md_to_html(mk_code, extentions={}, render_options={})
    render = Redcarpet::Render::HTML.new(render_options)
    Redcarpet::Markdown.new(render, extentions).render(mk_code).html_safe
  end
end