# frozen_string_literal: true

require 'helpers/markdown_helpers'

activate :aria_current
activate :autoprefixer
activate :directory_indexes
activate :syntax, line_numbers: false
activate :sprockets

activate :blog do |blog|
  blog.prefix = 'posts'

  blog.permalink = '{title}.html'
  blog.sources = '{year}/{month}/{day}-{title}.html'
  blog.taglink = '/tags/{tag}.html'
  blog.layout = 'post_layout'
  blog.summary_separator = /\(READMORE\)/
  blog.summary_length = 250
  blog.default_extension = '.md'
  blog.tag_template = 'tag.html'

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = 'page/{num}'

  # Categories
  blog.custom_collections = {
    course: {
      link: '/courses/{course}.html',
      template: '/course.html'
    },
    category: {
      link: '/categories/{category}.html',
      template: '/category.html'
    }
  }
end

set :markdown_engine, :redcarpet
set :markdown,
  autolink: true,
  fenced_code_blocks: true,
  footnotes: true,
  highlight: true,
  smartypants: true,
  strikethrough: true,
  tables: true,
  with_toc_data: true,
  renderer: MarkdownHelpers::DSRenderer

set :fonts_dir, 'fonts'
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

page '/*.json', layout: false
page '/*.txt', layout: false
page '/*.xml', layout: false

configure :development do
  activate :livereload

  activate :disqus do |disqus|
    disqus.shortname = 'dev-devsimple-ru'
  end
end

configure :build do
  activate :gzip
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash

  activate :favicon_maker do |f|
    f.template_dir = 'source/assets/images'
    f.icons = {
      '_favicon_template.png' => [
        { icon: 'apple-touch-icon-152x152-precomposed.png' },
        { icon: 'apple-touch-icon-114x114-precomposed.png' },
        { icon: 'apple-touch-icon-72x72-precomposed.png' },
        { icon: 'favicon.png', size: '16x16' },
        { icon: 'favicon.ico', size: '64x64,32x32,24x24,16x16' },
      ]
    }
  end

  activate :disqus do |disqus|
    disqus.shortname = 'devsimple-ru'
  end

  activate :deploy do |deploy|
    deploy.deploy_method = :git
    deploy.remote   = 'git@github.com:dev-simple/dev-simple.github.io.git'
    deploy.branch   = 'master'
    deploy.strategy = :submodule
    deploy.build_before = true
  end
end
