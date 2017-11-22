configure :development do
  activate :livereload
end


activate :aria_current
activate :autoprefixer

activate :directory_indexes

activate :syntax, line_numbers: false

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

activate :sprockets

set :css_dir, "stylesheets"
set :js_dir, "javascripts"
set :images_dir, "images"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"

  blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  blog.layout = "layout"
  blog.summary_separator = /\(READMORE\)/
  blog.summary_length = 250
  blog.year_link = "{year}.html"
  blog.month_link = "{year}/{month}.html"
  blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false

helpers do
  def find_author(author)
    result = data.authors.select {|a| a.keys.first == author}
    raise ArgumentError unless result.any?
    result.first
  end
end
